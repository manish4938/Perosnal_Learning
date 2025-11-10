// PromptTemplateResolver.cls
public class PromptTemplateResolver {
    public static String resolveTemplate(Id templateId, Map<String, Object> context) {
        Prompt_Template__c template = [
            SELECT Id, Template_Content__c, Data_Source_Type__c, Data_Source_Config__c 
            FROM Prompt_Template__c 
            WHERE Id = :templateId
        ];
        
        // Get data source results
        Map<String, Object> sourceData = resolveDataSource(
            template.Data_Source_Type__c,
            template.Data_Source_Config__c,
            context
        );
        
        // Apply template variables
        return applyTemplateVariables(template.Template_Content__c, sourceData);
    }
    
    public static Map<String, Object> resolveDataSource(
        String sourceType, 
        String sourceConfig, 
        Map<String, Object> context
    ) {
        Map<String, Object> result = new Map<String, Object>();
        
        try {
            Map<String, Object> config = (Map<String, Object>)JSON.deserializeUntyped(sourceConfig);
            
            switch on sourceType {
                when 'Flow' {
                    result = resolveFlowSource(config, context);
                }
                when 'SOQL' {
                    result = resolveSOQLSource(config, context);
                }
                when 'Object' {
                    result = resolveObjectSource(config, context);
                }
            }
        } catch(Exception e) {
            result.put('error', e.getMessage());
        }
        
        return result;
    }
    
    private static Map<String, Object> resolveFlowSource(Map<String, Object> config, Map<String, Object> context) {
        String flowApiName = (String)config.get('flowName');
        Map<String, Object> flowInputs = (Map<String, Object>)config.get('inputs');
        
        if(flowInputs == null) {
            flowInputs = new Map<String, Object>();
        }
        
        // Add context variables to flow inputs
        flowInputs.putAll(context);
        
        Flow.Interview flow = Flow.Interview.createInterview(flowApiName, flowInputs);
        flow.start();
        
        // Get the flow definition to find output variables
            List<FlowDefinitionView> flowDef = [
                SELECT ApiName, Label, ProcessType, TriggerType, 
                       Description, IsActive, VersionNumber
                FROM FlowDefinitionView 
                WHERE ApiName = :flowApiName 
                AND ProcessType = 'AutoLaunchedFlow'
                AND IsActive = true
                LIMIT 1
            ];
        
        if(flowDef.isEmpty()) {
                throw new FlowException('Flow not found or not an active auto-launched flow: ' + flowApiName);
            }
        
        List<String> variableNames = getFlowVariableNames(flowDef[0].label);
        
        Map<String, Object> result = new Map<String, Object>();
        for(String varName : variableNames) {
            Object value = flow.getVariableValue(varName);
            if(value != null) {
                result.put(varName, value);
            }
        }
        
        return result;
    }
    
    private static Map<String, Object> resolveSOQLSource(Map<String, Object> config, Map<String, Object> context) {
        String query = (String)config.get('query');
        
        // Replace context variables in query
        for(String key : context.keySet()) {
            query = query.replace(':' + key, String.valueOf(context.get(key)));
        }
        
        List<SObject> results = Database.query(query);
        return new Map<String, Object>{'results' => results};
    }
    
    private static Map<String, Object> resolveObjectSource(Map<String, Object> config, Map<String, Object> context) {
        String objectName = (String)config.get('objectName');
        String recordId = (String)context.get('recordId');
        
        if(String.isBlank(recordId)) {
            throw new PromptException('Record ID is required for object data source');
        }
        
        List<String> fields = (List<String>)config.get('fields');
        String soql = 'SELECT ' + String.join(fields, ',') + 
                     ' FROM ' + objectName + 
                     ' WHERE Id = :recordId';
        
        List<SObject> results = Database.query(soql);
        return new Map<String, Object>{'record' => results[0]};
    }
    
    private static String applyTemplateVariables(String template, Map<String, Object> data) {
        Pattern p = Pattern.compile('\\{\\{(.+?)\\}\\}');
        Matcher m = p.matcher(template);
        
        while(m.find()) {
            String variable = m.group(1).trim();
            Object value = resolvePath(data, variable.split('\\.'));
            template = template.replace('{{' + variable + '}}', String.valueOf(value));
        }
        
        return template;
    }
    
    private static Object resolvePath(Map<String, Object> data, String[] path) {
        Object current = data;
        
        for(String key : path) {
            if(current instanceof Map<String, Object>) {
                current = ((Map<String, Object>)current).get(key);
            } else if(current instanceof SObject) {
                current = ((SObject)current).get(key);
            } else {
                return null;
            }
        }
        
        return current;
    }
    
    private static List<String> getFlowVariableNames(String flowName) {
        List<String> variableNames = new List<String>();

        // Query Custom Metadata for the given Flow
        List<Prompt_Template_Flow_Variables_Mapping__c> mappings = [
            SELECT Name,Datatype__c,type__c 
            FROM Prompt_Template_Flow_Variables_Mapping__c 
            WHERE Prompt_Template_Flow_Mapping__r.name = :flowName
        ];

        for (Prompt_Template_Flow_Variables_Mapping__c mapping : mappings) {
            variableNames.add(mapping.name);
        }

        return variableNames;
    }
    
    public class PromptException extends Exception {}
}