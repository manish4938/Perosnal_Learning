public with sharing class PromptBuilderController {
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getAllTemplates() {
        List<Map<String, Object>> templates = new List<Map<String, Object>>();
        
        for(Prompt_Template__c template : [
            SELECT Id, Template_Name__c, Template_Content__c, Description__c, 
                   Active__c, Embedded_Queries__c, Embedded_Flows__c,
                   CreatedDate, LastModifiedDate 
            FROM Prompt_Template__c 
            WHERE Active__c = true 
            ORDER BY LastModifiedDate DESC
        ]) {
            Map<String, Object> templateMap = new Map<String, Object>{
                'id' => template.Id,
                'name' => template.Template_Name__c,
                'content' => template.Template_Content__c,
                'description' => template.Description__c,
                'embeddedQueries' => template.Embedded_Queries__c,
                'embeddedFlows' => template.Embedded_Flows__c,
                'createdDate' => template.CreatedDate,
                'lastModifiedDate' => template.LastModifiedDate
            };
            templates.add(templateMap);
        }
        
        return templates;
    }
    
    /*@AuraEnabled
    public static Prompt_Template__c saveTemplate(String name, String content, String description) {
        Prompt_Template__c template = new Prompt_Template__c(
            Template_Name__c = name,
            Template_Content__c = content,
            Description__c = description
        );
        
        insert template;
        return template;
    }*/
    
    @AuraEnabled
    public static Prompt_Template__c updateTemplate(Id templateId, String content, String description) {
        Prompt_Template__c template = [SELECT Id FROM Prompt_Template__c WHERE Id = :templateId];
        template.Template_Content__c = content;
        template.Description__c = description;
        
        update template; 
        return template;
    }
    
    @AuraEnabled
    public static void deleteTemplate(Id templateId) {
        delete [SELECT Id FROM Prompt_Template__c WHERE Id = :templateId];
    }
    
    @AuraEnabled
    public static Map<String, Object> resolveVariables(String templateContent, Map<String, String> userVariables) {
        Map<String, Object> result = new Map<String, Object>();
        
        // Extract variables using regex
        Pattern variablePattern = Pattern.compile('\\{\\{([^}]+)\\}\\}');
        Matcher matcher = variablePattern.matcher(templateContent);
        
        while (matcher.find()) {
            String variable = matcher.group(1);
            String variableType = getVariableType(variable);
            String variableContent = variable.substringAfter(':').trim();
            
            try {
                Object resolvedValue = resolveVariable(variableType, variableContent, userVariables);
                result.put(matcher.group(0), resolvedValue);
            } catch(Exception e) {
                result.put(matcher.group(0), 'Error: ' + e.getMessage());
            }
        }
        
        return result;
    }
    
    private static String getVariableType(String variable) {
        if (variable.startsWith('soql:')) return 'soql';
        if (variable.startsWith('flow:')) return 'flow';
        if (variable.startsWith('system:')) return 'system';
        return 'user';
    }
    
    private static Object resolveVariable(String type, String content, Map<String, String> userVariables) {
        switch on type {
            when 'soql' {
                return Database.query(content);
            }
            when 'flow' {
                //return executeFlow(content);
                return '';
            }
            when 'system' {
                return getSystemVariable(content);
            }
            when else {
                //return userVariables.get(content);
                return '';
            }
        }
    }
    
    
    
    private static Object getSystemVariable(String variable) {
        switch on variable {
            when 'currentDate' {
                return System.now();
            }
            when 'currentUser' {
                return UserInfo.getName();
            }
            when else {
                throw new AuraHandledException('Unknown system variable: ' + variable);
            }
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Prompt_Template__c> getTemplates() {
        return [SELECT Id, Template_Name__c, Template_Content__c, Description__c, 
                Active__c, Version__c,Embedded_Queries__c, Embedded_Flows__c,
                CreatedDate, LastModifiedDate 
                FROM Prompt_Template__c 
                WHERE Active__c = true 
                ORDER BY LastModifiedDate DESC];
    }
    
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getAvailableFlows() {
        Map<String, String> flowMap = new Map<String, String>();
        
        for(FlowDefinitionView flow : [
            SELECT Label, ApiName 
            FROM FlowDefinitionView 
            WHERE IsActive = true 
            AND ProcessType = 'Flow'
            ORDER BY Label
        ]) {
            flowMap.put(flow.ApiName, flow.Label);
        }
        
        return flowMap;
    }
    
    @AuraEnabled(cacheable=true)
    public static Map<String, List<String>> getObjectFields(String objectName) {
        Map<String, List<String>> fieldMaps = new Map<String, List<String>>();
        
        SObjectType objectType = Schema.getGlobalDescribe().get(objectName);
        if (objectType != null) {
            Map<String, Schema.SObjectField> fieldMap = objectType.getDescribe().fields.getMap();
            
            for (String fieldName : fieldMap.keySet()) {
                Schema.DescribeFieldResult field = fieldMap.get(fieldName).getDescribe();
                if (field.isAccessible()) {
                    String fieldType = String.valueOf(field.getType());
                    if (!fieldMaps.containsKey(fieldType)) {
                        fieldMaps.put(fieldType, new List<String>());
                    }
                    fieldMaps.get(fieldType).add(fieldName);
                }
            }
        }
        
        return fieldMaps;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<String> getSObjectTypes() {
        List<String> sObjectList = new List<String>();
        
        for(Schema.SObjectType objType : Schema.getGlobalDescribe().values()) {
            Schema.DescribeSObjectResult describe = objType.getDescribe();
            if(describe.isAccessible() && describe.isQueryable()) {
                sObjectList.add(describe.getName());
            }
        }
        
        return sObjectList;
    }
    
    @AuraEnabled
    public static String validateSOQL(String query) {
        try {
            Database.query(query);
            return 'Valid';
        } catch(Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
    
     @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getAvailableObjects() {
        List<Map<String, String>> objects = new List<Map<String, String>>();
        
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        for(String objectName : globalDescribe.keySet()) {
            Schema.DescribeSObjectResult describeResult = globalDescribe.get(objectName).getDescribe();
            if(describeResult.isAccessible() && describeResult.isQueryable()) {
                objects.add(new Map<String, String>{
                    'label' => describeResult.getLabel(),
                    'value' => objectName
                });
            }
        }
        //objects.sort();
        return objects;
    }

    @AuraEnabled
    public static Map<String, Object> executeQuery(String query) {
        try {
            List<SObject> results = Database.query(query);
            return new Map<String, Object>{
                'status' => 'success',
                'results' => results
            };
        } catch(Exception e) {
            return new Map<String, Object>{
                'status' => 'error',
                'message' => e.getMessage()
            };
        }
    }

    @AuraEnabled
    public static String executeFlow(String flowApiName, Map<String, Object> inputVariables) {
        try {
            // Create and start the flow interview
            Flow.Interview flow = Flow.Interview.createInterview(flowApiName, inputVariables);
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
            
            // Initialize output map
            Map<String, Object> outputValues = new Map<String, Object>();
            
            List<String> variableNames = getFlowVariableNames(flowDef[0].label);
            
            // Try to get common output patterns
            String[] commonOutputPatterns = new String[]{
                'Output', 'Result', 'Response', 'Return', 
                'Status', 'Success', 'Error', 'Message'
            };
            
            for(String pattern : variableNames) {
                try {
                    Object value = flow.getVariableValue(pattern);
                    if(value != null) {
                        outputValues.put(pattern, value);
                    }
                } catch(Exception e) {
                    // Ignore errors for pattern matching
                }
            }
            
            // Add flow execution status
            outputValues.put('flowStatus', 'FINISHED');
            String ret = JSON.serialize(outputValues); 
            System.debug('response '+ret);
            
            return JSON.serialize(outputValues); 
            
            
        } catch(Exception e) {
            Map<String, Object> merror=  new Map<String, Object>{
                'status' => 'ERROR',
                'errorMessage' => e.getMessage(),
                'errorType' => e.getTypeName(),
                'stackTrace' => e.getStackTraceString()
            };

            return JSON.serialize(merror);
        }
    }
    
    private static Object processValue(Object value) {
        if(value == null) return null;

        System.debug(value instanceof SObject);
        System.debug(value instanceof List<SObject>);
        
        try {
            if(value instanceof SObject) {
                return processSObject((SObject)value);
            } 
            else if(value instanceof List<SObject>) {
                return processSObjectList((List<SObject>)value);
            }
            else if(value instanceof List<Object>) {
                return processObjectList((List<Object>)value);
            }
            else if(value instanceof Blob) {
                return EncodingUtil.base64Encode((Blob)value);
            }
            else if(value instanceof Date) {
                return ((Date)value).format();
            }
            else if(value instanceof Datetime) {
                return ((Datetime)value).format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
            }
            else {
                return value;
            }
        } catch(Exception e) {
            return 'Error processing value: ' + e.getMessage();
        }
    }
    
    private static Map<String, Object> processSObject(SObject record) {
        Map<String, Object> recordMap = new Map<String, Object>();
        
        if(record != null) {
            Map<String, Object> populatedFields = record.getPopulatedFieldsAsMap();
            for(String fieldName : populatedFields.keySet()) {
                Object fieldValue = populatedFields.get(fieldName);
                if(fieldValue instanceof SObject) {
                    recordMap.put(fieldName, processSObject((SObject)fieldValue));
                } else {
                    recordMap.put(fieldName, processValue(fieldValue));
                }
            }
        }
        
        return recordMap;
    }
    
    private static List<Map<String, Object>> processSObjectList(List<SObject> records) {
        List<Map<String, Object>> processedRecords = new List<Map<String, Object>>();
        
        if(records != null) {
            for(SObject record : records) {
                processedRecords.add(processSObject(record));
            }
        }
        
        return processedRecords;
    }
    
    private static List<Object> processObjectList(List<Object> objects) {
        List<Object> processedObjects = new List<Object>();
        
        if(objects != null) {
            for(Object obj : objects) {
                processedObjects.add(processValue(obj));
            }
        }
        
        return processedObjects;
    }
    
    public class FlowException extends Exception {}

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

    /* private static Map<String, Object> executeFlow(String flowInfo) {
        Map<String, Object> flowOutputs = new Map<String, Object>();
        List<String> flowParts = flowInfo.split(',');
        String flowName = flowParts[0].trim();
        
        Map<String, Object> flowInputs = new Map<String, Object>();
        for (Integer i = 1; i < flowParts.size(); i++) {
            String[] inputParts = flowParts[i].trim().split('=');
            flowInputs.put(inputParts[0], inputParts[1]);
        }
        try { 
        Flow.Interview flow = Flow.Interview.createInterview(flowName, flowInputs);
        flow.start();

        // Use reflection to fetch all variables dynamically
            List<String> flowVariableNames = getFlowVariableNames(flow);

            for (String variableName : flowVariableNames) {
                Object value = flow.getVariableValue(variableName);
                if (value != null) {
                    flowOutputs.put(variableName, value);
                }
            }
        }catch(Exception ex){
            // Handle errors gracefully and include in the response
            flowOutputs.put('error', ex.getMessage());
        }
        
        return flowOutputs;
    }

   /* // Helper method to fetch variable names from the Flow (uses reflection)
    private static List<String> getFlowVariableNames(Flow.Interview flow) {
        List<String> variableNames = new List<String>();

        // Access Flow metadata using reflection
        try {
            Schema.DescribeSObjectResult flowDesc = flow.getSObjectDescribe();
            Map<String, Schema.FieldSet> fieldSets = flowDesc.fieldSets.getMap();
            for (String fieldSetName : fieldSets.keySet()) {
                variableNames.add(fieldSetName);
            }
        } catch (Exception e) {
            // Log error for debugging purposes
            System.debug('Error while fetching Flow variables: ' + e.getMessage());
        }

        return variableNames;
    }*/

    
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getFlowsList() {
        List<Map<String, String>> flows = new List<Map<String, String>>();
        
        for (FlowDefinitionView flow : [
            SELECT ApiName, Label, ProcessType
            FROM FlowDefinitionView
            WHERE ProcessType IN ('Flow', 'AutoLaunchedFlow')
            AND isActive = true
            ORDER BY Label
        ]) {
            flows.add(new Map<String, String>{
                'label' => flow.Label,
                'value' => flow.ApiName
            });
        }
        
        return flows;
    }

    @AuraEnabled
    public static Map<String, Object> executeSOQL(String query) {
        try {
            List<SObject> results = Database.query(query);
            return new Map<String, Object>{
                'status' => 'SUCCESS',
                'results' => results
            };
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Map<String, Object> saveTemplate(String name, String content, String existingTemplateId) {
        try {
            // Generate API name from template name
            String apiName = name.replaceAll('[^a-zA-Z0-9]', '_').replaceAll('__+', '_');
            apiName = apiName.toLowerCase() + '_template';
            
            // Check if this is a new version of existing template
            if (String.isNotBlank(existingTemplateId)) {
                return createNewVersion(existingTemplateId, content);
            } else {
                return createNewTemplate(name, apiName, content);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    private static Map<String, Object> createNewTemplate(String name, String apiName, String content) {
        // Check for existing template with same API name
        List<Prompt_Template__c> existing = [
            SELECT Id FROM Prompt_Template__c 
            WHERE ApiName__c = :apiName LIMIT 1 
        ];
        
        if (!existing.isEmpty()) {
            throw new AuraHandledException('A template with this name already exists');
        }
        
        // Create new template
        Prompt_Template__c template = new Prompt_Template__c(
            Name = name,
            ApiName__c = apiName,
            Template_Content__c = content,
            Version__c = 1,
            IsLatestVersion__c = true
        );
        
        insert template;
        
        return new Map<String, Object>{
            'id' => template.Id,
            'name' => template.Name,
            'version' => template.Version__c,
            'isNewTemplate' => true
        };
    }
    
    private static Map<String, Object> createNewVersion(String templateId, String content) {
        // Get current template
        Prompt_Template__c currentTemplate = [
            SELECT Id, Name, ApiName__c, Version__c 
            FROM Prompt_Template__c 
            WHERE Id = :templateId
        ];
        
        // Update all versions to not be latest
        List<Prompt_Template__c> oldVersions = [
            SELECT Id FROM Prompt_Template__c 
            WHERE ApiName__c = :currentTemplate.ApiName__c 
            AND IsLatestVersion__c = true
        ];
        
        for (Prompt_Template__c old : oldVersions) {
            old.IsLatestVersion__c = false;
        }
        update oldVersions;
        
        // Create new version
        Prompt_Template__c newVersion = new Prompt_Template__c(
            Name = currentTemplate.Name,
            ApiName__c = currentTemplate.ApiName__c,
            Template_Content__c = content,
            Version__c = currentTemplate.Version__c + 1,
            IsLatestVersion__c = true
        );
        
        insert newVersion;
        
        return new Map<String, Object>{
            'id' => newVersion.Id,
            'name' => newVersion.Name,
            'version' => newVersion.Version__c,
            'isNewTemplate' => false
        };
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Prompt_Template__c> getTemplateVersions(String apiName) {
        return [
            SELECT Id, Name, Version__c, CreatedDate, CreatedBy.Name, IsLatestVersion__c
            FROM Prompt_Template__c
            WHERE ApiName__c = :apiName
            ORDER BY Version__c DESC
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getTemplateRecord(String recordId) {
        Prompt_Template__c template = [
            SELECT Id, Name, Template_Content__c, Version__c, ApiName__c
            FROM Prompt_Template__c
            WHERE Id = :recordId
        ];
        
        return new Map<String, Object>{
            'id' => template.Id,
            'name' => template.Name,
            'content' => template.Template_Content__c,
            'version' => template.Version__c,
            'apiName' => template.ApiName__c
        };
    }
}