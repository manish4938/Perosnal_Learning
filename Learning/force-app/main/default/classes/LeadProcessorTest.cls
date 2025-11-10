@isTest
public class LeadProcessorTest {
    @isTest
    private static void methodTest(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i=0 ;i<200;i++) {
            Lead led = new Lead();
            led.FirstName = 'FirstName';
            led.LastName = 'LastName' +i;
            led.Company = 'demo' +i;
            led.Email ='test@gmail.com';
            leadList.add(led);
        }
        insert leadList;
        
        System.Test.startTest();
        LeadProcessor leadRec = new LeadProcessor();
        Database.executeBatch(leadRec);
        System.Test.stopTest();
    }
}