//@RestResource(urlMapping='/TwilioIntergration/*')
//global with sharing class TwilioIntergrationController
public class TwilioIntergrationController 
{
    /*public String toNumber  {get; set;}
    public String fromNumber  {get; set;}
    public String messageBody  {get; set;}*/
    
   /* @HttpPost
    global static void doPost() {
            RestRequest req = RestContext.request;
            RestResponse resp = RestContext.response;
            String sId=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
            System.debug('sId is'+sId);
            List<TwilioSF__Message__c> result=[SELECT TwilioSF__To_Number__c, TwilioSF__From_Number__c, TwilioSF__Body__c
                                         FROM TwilioSF__Message__c
                                         WHERE TwilioSF__Message_SID__c =: sId];
            
           //Blob body = req.requestBody;
           //String bodyString = body.toString();
           System.debug('Hello'+result);
           System.debug('Data Are'+req);
        RestRequest request = RestContext.request;
        String requestBody = request.requestBody.toString();
        System.debug('Test '+requestBody);
    }
    @HttpGet
     global static String doGet()
     {
         return 'Yes Hello World';
     }*/
    
    public TwilioIntergrationController()
    {
        String msgBody = ApexPages.currentPage().getParameters().get('Body');
        System.debug('msgBody '+ApexPages.currentPage().getParameters());
    }
    
}