public class AirtableCalloutLogService {
    
    List<Payload_Log__c> errorPayloadList = new List<Payload_Log__c>();
    private static final String SALESFORCE_ERROR = 'Salesforce Error';
    public void createErrorLog(List<AirtableCalloutWrapper>  airtableWrapList){
        
    }
    
    public void createErrorLogForSalesforceException(Exception e)
    {   
        String message = e.getMessage() + '\n' + e.getStackTraceString();
        Payload_Log__c payload = new Payload_Log__c( Message__c = message,Object_Type__c = 'AirTable__c',
                                                  
                                                  Type__c = SALESFORCE_ERROR);
        INSERT payload;
    }
}