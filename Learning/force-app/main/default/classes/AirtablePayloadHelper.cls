public class AirtablePayloadHelper {
    
    static List<AirTable__c> airTableList = new List<AirTable__c>();
    static AirtableWrapper airtableWrapper= new AirtableWrapper();
    
    public static void getAirTableData(List<AirtableCalloutResponse.AirtableRecordWrapper> recordsList){
        for(AirtableCalloutResponse.AirtableRecordWrapper record : recordsList) {
            System.debug('Record: '+record);
            System.debug('ID: ' + record.id);
            System.debug('Created Time: ' + record.createdTime);
            System.debug('Fields: ' + record.fields);
            AirTable__c airTableRecord= new AirTable__c();
            
            airTableRecord.Test__c =  airtableWrapper.setTest(record.fields.get('Test'));
            airTableRecord.Test1__c = airtableWrapper.setTest1(record.fields.get('Test1'));
            airTableRecord.Test2__c = airtableWrapper.setTest2(record.fields.get('Test2'));
            airTableRecord.Test3__c = airtableWrapper.setTest3(record.fields.get('Test3'));
            airTableRecord.Test4__c = airtableWrapper.setTest4(record.fields.get('Test4'));
            airTableList.add(airTableRecord);
        }
     if(airTableList.size() > 0){ 
        INSERT airTableList;
    }
}
    
   
 }