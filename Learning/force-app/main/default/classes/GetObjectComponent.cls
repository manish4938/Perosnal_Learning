public with sharing class GetObjectComponent {
    @AuraEnabled(cacheable=true)
    public static List<String> getAllObjects() {
        List<String> objectNames = new List<String>();
        // Get all objects in the Salesforce org
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        for (String objectName : globalDescribe.keySet()) {
                objectNames.add(objectName);
        }
        return objectNames;
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getObjectFields(String objectName) {
        List<String> fieldNames = new List<String>();
        // Get the object type dynamically based on objectName
        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(objectName);
        if (objectType != null) {
            // Get the fields for the object
            Map<String, Schema.SObjectField> fields = objectType.getDescribe().fields.getMap();
            for (String fieldName : fields.keySet()) {
                fieldNames.add(fieldName);
            }
        }
        return fieldNames;
    }
    /*
    @AuraEnabled(cacheable=true)
    public static List<Prompt_Template_Type__mdt> getCustomMetadata() {
        return [SELECT MasterLabel ,Prompt_Template_Type__c FROM Prompt_Template_Type__mdt];
    }*/
}