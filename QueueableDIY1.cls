public class QueueableDIY1 implements Queueable{
    
    Integer recordLimit;
    
    public QueueableDIY1(Integer recordLimit) {
        
        this.recordLimit = recordLimit;
    }
    
    public void execute(QueueableContext ctx) {
        
        ContactService.deleteContactsLastYear(recordLimit);
        system.enqueueJob(new QueueableDIY2());
        
    }

}