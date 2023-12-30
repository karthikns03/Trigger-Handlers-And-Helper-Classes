public class LeadTriggerHandler {
    
    List<Lead> triggerNew;
    List<Lead> triggerOld;
    Map<Id, Lead> triggerNewMap;
    Map<Id, Lead> triggerOldMap;
    
    static boolean recurssiveCheck = true;
    
    public LeadTriggerHandler() {
        triggerNew = (List<Lead>)Trigger.New;
        triggerOld = (List<Lead>)Trigger.Old;
        triggerNewMap = (Map<Id, Lead>)Trigger.NewMap;
        triggerOldMap = (Map<Id, Lead>)Trigger.OldMap;
    }
    
    public void doAction() {
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                onBeforeInsert();
            }
            when BEFORE_UPDATE {
                onBeforeUpdate();
            }
            when BEFORE_DELETE {
                onBeforeDelete();
            }
            when AFTER_INSERT {
                onAfterInsert();
            }
            when AFTER_UPDATE {
                onAfterUpdate();
            }
            when AFTER_DELETE {
                onAfterDelete();
            }
            when AFTER_UNDELETE {
                onAfterUnDelete();
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
        createDuplicateLeadRecord();
    }
    
    public void onAfterUpdate() {
        
    }
    
    public void onAfterDelete() {
        
    }
    
    public void onAfterUnDelete() {
        
    }
    
    public void createDuplicateLeadRecord() {
        
        if(recurssiveCheck) {
            recurssiveCheck = false;
            List<Lead> leadToInsert = new List<Lead>();
            leadToInsert = triggerNew.deepClone();
               
            if (!leadToInsert.isEmpty()) {
                try {
                    system.debug('1');
                    insert leadToInsert;
                } catch (DMLException e) {
                    System.debug(e.getMessage());
                }
            }
        }
        
    }
}