public class AirtableBatch implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return null;
    }
    public void execute(Database.BatchableContext bc, List<SObject> listRec){
        AirtableService.test();
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
}