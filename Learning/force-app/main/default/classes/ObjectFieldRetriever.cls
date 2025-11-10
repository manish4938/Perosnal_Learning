public class ObjectFieldRetriever {
    public static List<String> getObjectAndFieldName(){
       
        List<String> objName=new List<String>();
        Map<String, Schema.SObjectType> objectDetail=Schema.getGlobalDescribe();
        for(String objects:objectDetail.keyset()){
            objName.add(objects);
            system.debug('@@ Object Names Are '+objName);
        }
        //return objName;
       
        List<String> fieldName=new List<String>(); 
        Schema.SObjectType objType=Schema.getGlobalDescribe().get(objName[0]);
        if(objType!=null){
        Map<String, Schema.SObjectField>fields=objType.getDescribe().fields.getmap();
        for(String flName: fields.keyset()){
           fieldName.add(flName);
           system.debug('@@ Field Name Names Are '+fieldName);
        }
        }
        return fieldName;
   }
 
    class ObjectWrapper{
        
    }
    class FieldWrapper{
        
    }
   
}