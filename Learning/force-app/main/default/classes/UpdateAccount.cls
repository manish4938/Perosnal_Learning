public class UpdateAccount implements Database.Batchable<Sobject> {
    
    
    public Database.QueryLocator start(Database.BatchableContext contx){
        return DataBase.getQueryLocator('SELECT ID,NAME FROM Account');
    }
    
    public void execute(Database.BatchableContext cntx,List<Account> subListOfAccount){
        for(Account accRecord : subListOfAccount){
            accRecord.Name ='Updated Batch'+accRecord.Name;
        }
        UPDATE subListOfAccount;
    }
    public void finish(Database.BatchableContext cntx){
        System.debug('@@@ Finish Method Called');
    }
}