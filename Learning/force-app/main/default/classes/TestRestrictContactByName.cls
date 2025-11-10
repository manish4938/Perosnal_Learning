@isTest

public class TestRestrictContactByName

{

    @isTest static void ContactName1()

    {

        Contact c1 = new Contact(LastName='INVALIDNAME');

        //Test.startTest();

        Database.SaveResult result = Database.insert(c1, false);      

        //Test.stopTest();

        System.assert(!result.isSuccess());

        System.assert(result.getErrors().size() > 0);

        System.assertEquals('The Last Name "'+c1.LastName+'" is not allowed for DML',

                             result.getErrors()[0].getMessage());

    }

}