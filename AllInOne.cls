public class AllInOne implements Queueable, Database.Batchable<sObject>{
    
    public void execute(QueueableCOntext ctx) {
        
        futureMethod();
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator('Select Id, name from Account');
        
    }
    
    public void execute(Database.BatchableContext bc, List<Account> chunks) {
        futureMethod();
    }
    
    public void finish(Database.BatchableContext bc) {
        futureMethod();
    }
	
    @future
    public static void futureMethod() {
        
    }
}