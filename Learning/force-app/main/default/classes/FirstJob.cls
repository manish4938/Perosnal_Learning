public class FirstJob implements Queueable
{
    public void execute(QueueableContext qct1)
    {
        Delete [select id from Iuser__c where last_name__c='Raj'];
        
        
    }

}