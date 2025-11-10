public class TestQueueable implements Queueable {

    public void execute(QueueableContext cntx){
        DELETE [Select Id from Lead where name like '%A%'];
    }
}