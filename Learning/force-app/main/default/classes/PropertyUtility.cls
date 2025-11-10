public class PropertyUtility {
    public static void newListedProperties(){
        List<Property__c> newPropList = new List<Property__c>();
        String propEmail;
        newPropList = [Select Name,Broker_Email__c,Property_Listed__c from Property__c where Property_Listed__c  = LAST_N_DAYS:30];
        for(Property__c properRec : newPropList){
            propEmail = properRec.Name+':'+properRec.Broker_Email__c;
            System.debug('propEmail '+propEmail);
        }
    }
}