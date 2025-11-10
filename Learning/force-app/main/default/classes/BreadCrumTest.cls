/**
* @File Name : BreadCrumTest.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : January 24, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | January 24, 2025 |   | Initial Version
**/

public class BreadCrumTest {
    
	@AuraEnabled(cacheable=true)
    public static List<String> getSObjectList() {
        List<String> objName=new List<String>();
        Map<String, Schema.SObjectType> objectDetail=Schema.getGlobalDescribe();
        for(String objects:objectDetail.keyset()){
            objName.add(objects);
        }
        return objName;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldList(String objectName) {
        Map<String, Schema.SObjectField> fields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        return new List<String>(fields.keySet());
    }
}