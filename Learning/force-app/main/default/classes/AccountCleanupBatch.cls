public class AccountCleanupBatch implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator('SELECT Id, Is_Orphan__c FROM Account WHERE Id NOT IN (SELECT AccountId FROM Contact)');

    }
    public void execute(Database.BatchableContext  bc,List<Account> accList){
        for(Account accRec : accList){
            accRec.Is_Orphan__c = true;
        }
        UPDATE accList;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('@@@ FInish Method');
    }
    
}