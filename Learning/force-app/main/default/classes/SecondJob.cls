public class SecondJob implements Queueable
{
    //It is used to fetch job id as well  :--In run window :- String abc=system.enqueueJob(job_name);
    //Chaining of jobs are possible, user can pass non-primtive data type as well
    public void execute(QueueableContext qct2)
    {
        Delete[select id from data_plan__c where price__c=100];
        
        System.enqueueJob(new FirstJob());
        
    }

}