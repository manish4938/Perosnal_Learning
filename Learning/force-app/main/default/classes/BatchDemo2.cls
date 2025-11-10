public class BatchDemo2 implements Database.Batchable<Sobject>
{
    public Database.QueryLocator start(Database.BatchableContext ba)
    {
        return Database.getQueryLocator('select id,last_name__c from Iuser__c');
    }
    public void execute(Database.BatchableContext ba,List<Iuser__c> subListFromStartMethod)
    {
        for(Iuser__c bc:subListFromStartMethod)
        {
            bc.last_name__c='Raj';
        }
        update subListFromStartMethod;
    }
    public void finish(Database.BatchableContext ba)
    {
        System.debug('All Batch Has been Update..!!');
    }
//For execution Database.executeBatch(new ClassName(),Per batch number od records[int value] max=2000 as per gov limit,min=1,defualt=200);
//To chain another batch database.executeBatch(new batchClass2());
}