public class ContrlPickListFieldHandler {
    
    List<Interview_TOpic__c> triggerNew = new List<Interview_TOpic__c>();
    Map<Id, Interview_TOpic__c> triggerOldMap = new Map<Id, Interview_TOpic__c>();
    
    public ContrlPickListFieldHandler() {
        
        triggerNew = (List<Interview_TOpic__c>)Trigger.old;
        triggerOldMap = (Map<Id, Interview_TOpic__c>)Trigger.OldMap;
        doAction();
    }
    
    public void doAction() {
        
        Switch on Trigger.OperationType {
            
            When BEFORE_UPDATE {
                onBeforeUpdate();
            }
        }
    }
    
    public void onBeforeUpdate() {
        
        Map<Id, Profile> profileMap = new Map<Id, Profile>([Select Id, Name from Profile Where Id =: UserInfo.getProfileId()]);        
        for(Interview_TOpic__c record : triggerNew) {            
            if((triggerOldMap.get(record.Id).STatus__c != record.STatus__c) && triggerOldMap.get(record.Id).STatus__c == 'Approved') {                
                if(profileMap.get(UserInfo.getProfileId())?.Name == 'System Administrator') {
                    record.addError('You are not allowed to Update this record');
                }
            }
        }
    }
}