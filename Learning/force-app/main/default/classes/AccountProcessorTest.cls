@isTest
public class AccountProcessorTest {
    @isTest
    public static void countContactsTest(){
        Account a = new Account();
        a.Name = 'Test Account';
        a.Rating ='Cold';
        INSERT a;
        Contact con= new Contact();
        con.FirstName = 'Manish';
        con.LastName = 'Raj';
        con.Email = 'mqan@gmail.com';
        con.AccountId = a.Id;
        INSERT con;
        Set<Id> accIds = new Set<Id>();
        accIds.add(a.Id);
        
        System.Test.startTest();
        AccountProcessor.countContacts(accIds);
        System.Test.stopTest();
        
        Account acc = [Select Number_Of_Contacts__c from Account where Id =: a.Id limit 1];
        System.assertEquals(Integer.valueOf(acc.Number_Of_Contacts__c),1);
    }
}