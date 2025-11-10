public with sharing class PromptBuilder {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getAllTemplates() {
        List<Map<String, Object>> templates = new List<Map<String, Object>>();
        
        for(Prompt_Template__c template : [
            SELECT Id, Template_Name__c, Template_Content__c, 
                   Data_Source_Type__c, Data_Source_Config__c,
                   Active__c, CreatedDate, LastModifiedDate 
            FROM Prompt_Template__c 
            WHERE Active__c = true  
            ORDER BY LastModifiedDate DESC
        ]) {
            templates.add(new Map<String, Object>{
                'id' => template.Id,
                'name' => template.Template_Name__c,
                'content' => template.Template_Content__c,
                'dataSourceType' => template.Data_Source_Type__c,
                'dataSourceConfig' => template.Data_Source_Config__c,
                'createdDate' => template.CreatedDate,
                'lastModifiedDate' => template.LastModifiedDate
            });
        }
        return templates;
    }
    
    @AuraEnabled
    public static Map<String, Object> saveTemplate(
        String name, 
        String content, 
        String dataSourceType,
        String dataSourceConfig,
        String existingTemplateId
    ) {
        try {
            Prompt_Template__c template;
            if (String.isNotBlank(existingTemplateId)) {
                template = [SELECT Id FROM Prompt_Template__c WHERE Id = :existingTemplateId];
                template.Template_Content__c = content;
                template.Data_Source_Type__c = dataSourceType;
                template.Data_Source_Config__c = dataSourceConfig;
            } else {
                template = new Prompt_Template__c(
                    Template_Name__c = name,
                    Template_Content__c = content,
                    Data_Source_Type__c = dataSourceType,
                    Data_Source_Config__c = dataSourceConfig,
                    Active__c = true
                );
            }
            
            upsert template;
            return new Map<String, Object>{
                'id' => template.Id,
                'status' => 'success'
            };
        } catch (Exception e) {
            return new Map<String, Object>{
                'status' => 'error',
                'message' => e.getMessage()
            };
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getFlowsList() {
        List<Map<String, String>> flows = new List<Map<String, String>>();
        
        for (FlowDefinitionView flow : [
            SELECT ApiName, Label 
            FROM FlowDefinitionView 
            WHERE IsActive = true 
            AND ProcessType = 'Flow'
            ORDER BY Label
        ]) {
            flows.add(new Map<String, String>{
                'label' => flow.Label,
                'value' => flow.ApiName
            });
        }
        
        return flows;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getObjectsList() {
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
        
        return objects;
    }
    
    @AuraEnabled(cacheable=true)
    public static Map<String, List<String>> getObjectFields(String objectName) {
        Map<String, List<String>> fieldMap = new Map<String, List<String>>();
        
        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(objectName);
        if (objectType != null) {
            Map<String, Schema.SObjectField> fields = objectType.getDescribe().fields.getMap();
            
            for(String fieldName : fields.keySet()) {
                Schema.DescribeFieldResult field = fields.get(fieldName).getDescribe();
                if(field.isAccessible()) {
                    String fieldType = String.valueOf(field.getType());
                    if(!fieldMap.containsKey(fieldType)) {
                        fieldMap.put(fieldType, new List<String>());
                    }
                    fieldMap.get(fieldType).add(fieldName);
                }
            }
        }
        
        return fieldMap;
    }
    
    @AuraEnabled
    public static Map<String, Object> validateSOQL(String query) {
        try {
            List<SObject> results = Database.query(query);
            return new Map<String, Object>{
                'status' => 'success',
                'count' => results.size()
            };
        } catch(Exception e) {
            return new Map<String, Object>{
                'status' => 'error',
                'message' => e.getMessage()
            };
        }
    }
}