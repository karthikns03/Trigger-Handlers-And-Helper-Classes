public class TriggerHandler {

    List<Task> triggerOld;
    //COnstant variable
    
    final String SYSTEM_ADMINISTRATOR_NAME = 'System Administrator';
    
    public TriggerHandler() {
        
        triggerOld = (List<Task>)Trigger.Old;
        doAction();
    }
    
    public void doAction() {
        
        switch on Trigger.OperationType {
            
            When BEFORE_DELETE {
                onBeforeDelete();
            }
        }
    }
    
    public void onBeforeDelete() {
        preventDeletingTaskOtherThanAdministrator();
    }
    
    public void preventDeletingTaskOtherThanAdministrator() {
        
        Map<Id, Profile> userProfileMap = new Map<Id, Profile>([Select Id, Name 
                                                          From Profile 
                                                          Where Id =: UserInfo.getProfileId()]);
        for(Task taskRecord : triggerOld) {
            
            String userProfileName = userProfileMap.get(UserInfo.getProfileId()).Name;
            
            if(userProfileName != SYSTEM_ADMINISTRATOR_NAME) {
                taskRecord.addError('You cannot delete Task unless you are a Administrator');
            }
        }
    }
}