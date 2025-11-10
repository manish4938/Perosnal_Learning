@isTest
public class AddPrimaryContactTest {
    
    @testSetup
    static void setup() {
        List<Account> insertAccount = new List<Account>();
        for(integer i=0; i<=100; i++) {
            if(i <=50) {
                insertAccount.add(new Account(Name='Acc'+i, BillingState = 'NY', Rating ='Hot'));
            } else {
                insertAccount.add(new Account(Name='Acc'+i, BillingState = 'CA',Rating ='Hot'));
            }
        }
        insert insertAccount;
    }
    
    static testMethod void testAddPrimaryContact() {
        Contact con = new Contact(LastName = 'LastName');
        AddPrimaryContact addPC = new AddPrimaryContact(con, 'CA');
        System.Test.startTest();
        system.enqueueJob(addPC);
        System.Test.stopTest();
        system.assertEquals(50, [select count() from Contact]);
    }
    
}