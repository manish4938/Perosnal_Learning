public class AccountHandler 
{
   /*
   public static void insertData(List<Account> newlist)
   {
       for(Account acc:newlist)
       {
           if(acc.Industry !=null && acc.Industry=='Media')
           {
               acc.Rating='Hot';
           }
 }}
    public static void createRelatedOpp(List<Account> newlist)
    {
        List<Opportunity> oppToBeInserted=new List<Opportunity>();
        for(Account acc:newlist)
        {
            Opportunity opp=new Opportunity();
            opp.Name=acc.Name;
            opp.AccountId=acc.Id;
            opp.StageName='Prospecting';
            opp.CloseDate=System.today();
            oppToBeInserted.add(opp);
            
         }
         if(!oppToBeInserted.isEmpty())
         {
           insert oppToBeInserted; 
         }
    }
    public static void updatePhone(List<Account> newList, Map<id,Account> oldMap)
    {
        for(Account acc:newList)
        {
            if(oldMap!=null && acc.Phone !=oldMap.get(acc.Id).phone)
            {
                acc.Description='Phone is Modified On Account';

                
            }
        }
        
    }
    public static void updateRelatedPhone(List<Account> newList,Map<Id,Account> oldMap)
    {
        Map<Id,Account> accIdToAccountMap=new Map<Id,Account>();
        List<Opportunity> oppToBeUpdated=new  List<Opportunity>();
        
        for(Account acc:newlist)
        {
           if(oldMap!=null && acc.Phone !=oldMap.get(acc.Id).phone)
            {

                 accIdToAccountMap.put(acc.id,acc);
            }  
         }
        for(Opportunity opp:[select Id,Phone__c,AccountId from Opportunity where AccountId IN:accIdToAccountMap.keySet()])
        {
            Opportunity oppr=new Opportunity();
            if(accIdToAccountMap.containsKey(opp.AccountId))
            {
                oppr.id=opp.Id;
                oppr.Phone__c=accIdToAccountMap.get(opp.AccountId).Phone;
               oppToBeUpdated.add(oppr);
            }
            
        }
        if(!oppToBeUpdated.isEmpty())
        {
            update oppToBeUpdated;
        }
    }
    */
    
    public static void insertAccount(Integer numberOfNewAccounts){
         Integer N = 1;
         List<Account> addAccounts = new List<Account>();
         
         while(N <= numberOfNewAccounts){
            Account store = new Account();
            store.Name = 'Acme Inc ' + N;
            store.AccountNumber = 'A000' + N;
            addAccounts.add(store);
            N = N + 1;
           
        }
        System.debug('addAccounts '+addAccounts);
        if(addAccounts.size()>0){
            INSERT addAccounts;
        }
    }
    
}