public class ABC
{
    public static void m1()
    {
       
      List<List<SObject>> searchList = [FIND 'Sakshi4938@gmail.com' IN ALL FIELDS 
                                        RETURNING Iuser__c(age__c,first_name__c)];
        System.debug(searchList);
    }

}