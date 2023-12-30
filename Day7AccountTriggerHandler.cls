public class Day7AccountTriggerHandler {
    
    List<Account> triggerNew;
    List<Account> triggerOld;
    Map<Id, Account> triggerNewMap;
    Map<Id, Account> triggerOldMap;
    
    public Day7AccountTriggerHandler() {
        
        triggerNew = (List<Account>)Trigger.New;
        triggerOld = (List<Account>)Trigger.Old;
        triggerNewMap = (Map<Id, Account>)Trigger.NewMap;
        triggerOldMap = (Map<Id, Account>)Trigger.OldMap;
        
    }
    
    public void doAction() {
        
        Switch on Trigger.OperationType {
            
            When BEFORE_INSERT {
                onBeforeInsert();
            }
            
            When BEFORE_UPDATE {
                onBeforeUpdate();
            }
            
            When BEFORE_DELETE {
                onBeforeDelete();
            }
            
            When AFTER_INSERT{
                onAfterInsert();
            }
            
            When AFTER_UPDATE{
                onAfterUpdate();
            }
            
            When AFTER_DELETE{
                onAfterDelete();
            }
            
            When AFTER_UNDELETE{
                onAfterUndelete();
            }
        }
    }
    
    public void onBeforeInsert() {
        
    }
    
    public void onBeforeUpdate() {
        
    }
    
    public void onBeforeDelete() {
        
    }
    
    public void onAfterInsert() {
        
    }
    
    public void onAfterUpdate() {
        
    }
    
    public void onAfterDelete() {
        
    }
    
    public void onAfterUndelete() {
        
    }
    
    public void updateOpportunity() {
        
        DateTime day30 = Date.Today()+30;
        
        List<Opportunity> listToUpdate = new List<Opportunity>();
        for(Opportunity oppRec : [Select StageName 
                                  From Opportunity 
                                  Where AccountId In: triggerNew 
                                  		And StageName != 'Closed Won' 
                                  		AND CreatedDate < :day30]) {
            
                oppRec.StageName = 'Closed Lost';
            	listToUpdate.add(oppRec);
        }
        
        if(!listToUpdate.isEmpty()) {
            try {
                update listToUpdate;
            } catch (DMLException e) {
                system.debug(e.getMessage());
            }
        }
    }
    
}