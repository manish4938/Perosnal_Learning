public class AirtableSynSettings {

     public static String getEndPointURL(){
        return Air_Table_Syn_Meta_Data__mdt.getInstance('Air_Table_Syn').Endpoint_URL__c;
    }
    
    public static String getBearerToken(){
        return Air_Table_Syn_Meta_Data__mdt.getInstance('Air_Table_Syn').Bearer_Token__c;
    }
}