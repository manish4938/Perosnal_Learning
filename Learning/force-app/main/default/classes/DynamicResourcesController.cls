public with sharing class DynamicResourcesController {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getDynamicResources() {
        List<Map<String, String>> resources = new List<Map<String, String>>();

        // Current User and Organization
        resources.add(new Map<String, String>{'label' => 'Current User', 'value' => 'CurrentUser', 'category' => 'Metadata'});
        resources.add(new Map<String, String>{'label' => 'Current Organization', 'value' => 'CurrentOrganization', 'category' => 'Metadata'});

        // Apex Classes
        for (ApexClass apexClass : [SELECT Name FROM ApexClass WHERE Status = 'Active']) {
            resources.add(new Map<String, String>{'label' => 'Apex Class: ' + apexClass.Name, 'value' => apexClass.Name, 'category' => 'Apex'});
        }

        // Flows
        for (FlowDefinitionView flow : [SELECT ApiName FROM FlowDefinitionView WHERE ActiveVersionId != NULL]) {
            resources.add(new Map<String, String>{'label' => 'Flow: ' + flow.ApiName, 'value' => flow.ApiName, 'category' => 'Flow'});
        }

         // Salesforce Objects
        List<EntityDefinition> entityList = [SELECT QualifiedApiName FROM EntityDefinition WHERE IsCustomizable = true LIMIT 100]; // Limit to avoid over-fetching
        Set<String> objectNames = new Set<String>();

        // Add each object name to the set
        for (EntityDefinition entity : entityList) {
            objectNames.add(entity.QualifiedApiName);
            resources.add(new Map<String, String>{'label' => entity.QualifiedApiName, 'value' => entity.QualifiedApiName, 'category' => 'Object'});
        }

        // Fetch fields for all objects in one query using the IN clause
        List<FieldDefinition> fieldList = [SELECT QualifiedApiName, EntityDefinition.QualifiedApiName FROM FieldDefinition WHERE EntityDefinition.QualifiedApiName IN :objectNames LIMIT 100]; // Modify LIMIT if needed

        // Add fields for each object to the resources list
        for (FieldDefinition field : fieldList) {
            resources.add(new Map<String, String>{'label' => 'Field: ' + field.QualifiedApiName, 'value' => field.QualifiedApiName, 'category' => 'Field', 'relatedTo' => field.EntityDefinition.QualifiedApiName});
        }

        return resources;
    }
}