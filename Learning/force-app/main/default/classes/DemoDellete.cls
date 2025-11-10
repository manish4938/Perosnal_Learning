public class DemoDellete
{
    public static void m1()
    {
        List<Iuser__c> abc=([select first_name__c from Iuser__c]);
        for(Iuser__c b:abc )
        {
            System.debug(b);
        }
       

        
    }

}