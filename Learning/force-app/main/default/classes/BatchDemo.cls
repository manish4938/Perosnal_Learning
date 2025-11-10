public class BatchDemo implements Database.Batchable<Sobject>
{
    public Database.QueryLocator start(Database.BatchableContext ba)
    {
        return Database.getQueryLocator('select id,first_name__c from Iuser__c');
    }
    public void execute(Database.BatchableContext ba,List<Iuser__c> subListFromStartMethod)
    {
        for(Iuser__c bc:subListFromStartMethod)
        {
            bc.first_name__c='Manish';
        }
        update subListFromStartMethod;
    }
    public void finish(Database.BatchableContext ba)
    {
        System.debug('All Batch Has been Update..!!');
        Database.executeBatch(new BatchDemo2(),1);
    }
    
//For execution Database.executeBatch(new ClassName(),Per batch number od records[int value] max=2000 as per gov limit,min=1,defualt=200);
}