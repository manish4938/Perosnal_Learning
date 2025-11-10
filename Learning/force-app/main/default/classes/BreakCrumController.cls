/**
* @File Name : BreakCrumController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : January 23, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | January 23, 2025 |   | Initial Version
**/

public class BreakCrumController {
	@AuraEnabled(cacheable=true)
    public static List<String> getApexClassNames() {
        List<String> apexClassNames = new List<String>();
        for (ApexClass apexClass : [SELECT Name FROM ApexClass WHERE Status = 'Active' ORDER BY Name]) {
            apexClassNames.add(apexClass.Name);
        }
        return apexClassNames;
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getFlowNames() {
        List<String> flowNames = new List<String>();
        for (FlowDefinitionView flow : [SELECT Label FROM FlowDefinitionView WHERE ActiveVersionId != null ORDER BY Label]) {
            flowNames.add(flow.Label);
        }
        return flowNames;
    }
    @AuraEnabled(cacheable=true)
    public static List<String> getObjectName(){
        List<String> objName=new List<String>();
        Map<String, Schema.SObjectType> objectDetail=Schema.getGlobalDescribe();
        for(String objects:objectDetail.keyset()){
            objName.add(objects);
        }
        return objName;
    }
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldName(String objectName){
        system.debug('Object Selected :'+objectName);
        List<String> fieldName=new List<String>(); 
        Schema.SObjectType objType=Schema.getGlobalDescribe().get(objectName);
        if(objType!=null){
        Map<String, Schema.SObjectField>fields=objType.getDescribe().fields.getmap();
        for(String flName: fields.keyset()){
           fieldName.add(flName); 
        }
        }
        return fieldName;

    }
  
    
    @AuraEnabled(cacheable=true)
    public static Map<String, List<String>> fetchMetadata() {
        Map<String, List<String>> metadataMap = new Map<String, List<String>>();
        
        // Fetch Apex classes
        List<ApexClass> apexClasses = [SELECT Name FROM ApexClass WHERE Status = 'Active'];
        List<String> apexClassNames = new List<String>();
        for (ApexClass cls : apexClasses) {
            apexClassNames.add(cls.Name);
        }
        metadataMap.put('Apex Classes', apexClassNames);
        
        // Fetch Flows
        List<FlowDefinitionView> flows = [SELECT Label FROM FlowDefinitionView WHERE ActiveVersionId !=NULL];
        List<String> flowNames = new List<String>();
        for (FlowDefinitionView flow : flows) {
            flowNames.add(flow.Label);
        }
        metadataMap.put('Flows', flowNames);
        
        return metadataMap;
    }
    
}