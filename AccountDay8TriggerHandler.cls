public class AccountDay8TriggerHandler {
    
    List<Account> triggerNew;
    List<Account> triggerOld;
    Map<Id, Account> triggerNewMap;
    Map<Id, Account> triggerOldMap;
    
    public AccountDay8TriggerHandler() {
        triggerNew = (List<Account>)Trigger.New;
        triggerOld = (List<Account>)Trigger.Old;
        triggerNewMap = (Map<Id, Account>)Trigger.Newmap;
        triggerOldMap = (Map<Id, Account>)Trigger.Oldmap;
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
    
    public void sendEmalilAfterCreatingAccountRecord() {
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        List<User> userList = [Select id, Email from User Where Profile.name = 'System Administrator' Limit 1];
        
        for(Account accountRec : triggerNew) {
            
            Messaging.SingleEMailMessage mail = new Messaging.SingleEMailMessage();
            mail.toAddresses = new List<String>{userList[0].email};
            mail.subject = 'New Account Creatd';
            mail.htmlbody = 'A new Account Created' + accountRec.name;
            emailList.add(mail);
        }
        
        Messaging.sendEmail(emailList);
    }
}