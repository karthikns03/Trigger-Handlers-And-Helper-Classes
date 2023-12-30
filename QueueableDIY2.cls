public class QueueableDIY2 implements Queueable{
    
    public void execute(QueueableContext ctx) {
        
        AccountService.deleteAccountRecords(5);
        system.enqueueJob(new QueueableDIY1(5));
    }

}