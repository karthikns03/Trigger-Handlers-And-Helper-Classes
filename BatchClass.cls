public class BatchClass implements Database.Batchable<sObject>{
    
    //start - return in Database.QueryLocatore
    String rating;
    public BatchClass(String rating) {
        this.rating = rating;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
       // system.debug('Start Method');
        String rating = 'Hot';
        String query = 'Select Id, Name from Account Where Rating =:rating';
        system.debug(query);
        return Database.getQueryLocator(query);
    }
    
    //execute
    public void execute(Database.BatchableContext bc, List<Account> chunks) {
        //Business Logic
        system.debug('Execute Method');
        system.debug(chunks.size());
        Integer count = 0;
        for(Account acc : chunks) {
            count += 1;
        }
        
        system.debug(count);
    }
    
    
    //finish
	public void finish(Database.BatchableContext bc) {
        system.debug('Finist Method');
    }
}