public class AirtableSyncScheduler implements Schedulable {
    String conExp='0 0 0 * * ? *'; 
    public  void execute(SchedulableContext con){
        //system.schedule('Test',conExp, new AirtableBatch());
        //Database.executeBatch(new AirtableService());
    }
}