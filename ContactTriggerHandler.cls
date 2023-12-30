public class ContactTriggerHandler {
    
    List<Contact> triggerNew;
    List<COntact> triggerOld;
    Map<Id, Contact> triggerNewMap;
    Map<Id, COntact> triggerOldMap;
    
    public ContactTriggerHandler() {
        
        triggerNew = (List<Contact>)Trigger.New;
        triggerOld = (List<Contact>)Trigger.Old;
        triggerNewMap = (Map<Id, Contact>)TriggerNewMap;
        triggerOldMap = (Map<Id, Contact>)TriggerOldMap;
        
    }
    
    public void doAction() {
        
        Switch on Trigger.OperationType {
            
            When AFTER_INSERT {
                onAfterInsert();
            }
            
            When AFTER_UPDATE {
                onAfterUpdate();
            }
            
            When AFTER_DELETE {
                onAfterDelete();
            }
            
            When AFTER_UNDELETE {
                onAfterUndelete();
            }
        }
        
    }
    
    public void onAfterInsert() {
        calculateNumberOfContacts();
    }
    
    public void onAfterUpdate() {
        calculateNumberOfContacts();
    }
    
    public void onAfterDelete() {
        calculateNumberOfContacts();
    }
    
    public void onAfterUndelete() {
        calculateNumberOfContacts();
    }
    
    public void calculateNumberOfContacts() {
        
        List<Contact> conList = Trigger.isDelete ? triggerOld : triggerNew;
        
        for(Contact conRecord : conList) {
            
            if(conRecord.accountId != NULL) {
                
                ContactTriggerHandlerHelper.calculateNumberOfContactsHeler(conRecord.accountId);
            }
            
        }
    }

}