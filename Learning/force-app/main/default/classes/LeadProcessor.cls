public class LeadProcessor implements  Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('Select Id,LeadSource From Lead');
    }
    public void execute(Database.BatchableContext bc, List<Lead> leadList){
        for(Lead leadRec : leadList){
            leadRec.LeadSource = 'Dreamforce';
        }
        UPDATE leadList;
    }
    public void finish(Database.BatchableContext bc){
    }
}