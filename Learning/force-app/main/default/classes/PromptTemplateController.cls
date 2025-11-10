public with sharing class PromptTemplateController {
    @AuraEnabled(cacheable=true)
    public static List<Prompt_Template__c> getTemplates() {
        return [SELECT Id, Name, Template_Content__c, Description__c FROM Prompt_Template__c];
    }

    @AuraEnabled
    public static void saveTemplate(Prompt_Template__c template) {
        if (template.Id == null) {
            insert template;
        } else {
            update template;
        }
    }

    @AuraEnabled
    public static String renderTemplate(String templateContent, Map<String, String> variables) {
        String result = templateContent;
        for (String key : variables.keySet()) {
            String placeholder = '{' + key + '}';
            result = result.replace(placeholder, variables.get(key));
        }
        return result;
    }
}