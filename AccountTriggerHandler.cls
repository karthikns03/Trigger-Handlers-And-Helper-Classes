/*
* @Description : Trigger Handler for Trigger on Account 
* @Author      : Karthik S
* @Date        : 17-11-2023
*********************************************************************************************************************************************
Modification Log
Version       Developer       Date          Description
---------------------------------------------------------------------------------------------------------------------------------------------
1.0           Karthik S	   17-11-2023    Creaed Class
*/
public class AccountTriggerHandler {
    
    //Declaring variables for Trigger Context Variables
    List<Account> triggerNew;
    List<Account> triggerOld;
    Map<Id, Account> triggerNewMap;
    Map<Id, Account> triggerOldMap;
    
    //Static set
    Static Set<Id> staticAccID = new Set<Id>();
    //Assigning values for variables from trigger Context variables
    public AccountTriggerHandler() {
        triggerNew = (List<Account>)trigger.new;
        triggerOld = (List<Account>)trigger.Old;
        triggerNewMap = (Map<Id, Account>)trigger.NewMap;
        triggerOldMap = (Map<Id, Account>)trigger.OldMap;
        
        doAction();
    }
    
    //Setting on whivh event trigger should fire
    public void doAction() {
        
        Switch On Trigger.OperationType {
            
            When BEFORE_INSERT {
                onBeforeInsert();
            }
            When AFTER_INSERT {
                onAfterInsert();
            }
            When BEFORE_UPDATE {
                onBeforeUpdate();
            }
            When AFTER_UPDATE {
                onAfterUpdate();
            }
            When BEFORE_DELETE {
                onBeforeDelete();
            }
            When AFTER_DELETE {
                onAfterDelete();
            }
            When AFTER_UNDELETE {
                onAfterUndelete();
            }
            
        }
    }
    
    //What should happen on Before Insert
    public void onBeforeInsert() {
        
    }
    
    //What should happen on After Insert
    public void onAfterInsert() {
        createNumberOfContacts();
    }
    
    //What should happen on Before Update
    public void onBeforeUpdate() {
        
    }
    
    //What should happen on After Update
    public void onAfterUpdate() {
        createNumberOfContacts();
    }
    
    //What should happen on Before Delete
    public void onBeforeDelete() {
        preventAccountDeletion();
    }
    
    //What should happen on After Delete
    public void onAfterDelete() {
        createNumberOfContacts();
    }
    
    //What should happen on After Undelete
    public void onAfterUndelete() {
        createNumberOfContacts();
    }    
    /************************************************************************************************************************************
* @Description    : This method performs Prevent user from Deleting Account Record except SYSTEM ADMINISTRATOR
* @Param          : No Param
* @Return         : No Return
************************************************************************************************************************************/  
    public void preventAccountDeletion() {       
        List<User> userprofileName = [Select Profile.Name from User Where Id =: UserInfo.getUserId()];   // Getting User PRofile Name   
        for(Account accRec : triggerOld) {           
            if(!userprofileName.isEmpty()) {
                if(userprofileName[0].Profile.Name != 'System Administrator') {
                    accRec.addError('You are not allowed to Delete this Record'); 
                }
            }
        }
    }
    
    
    /************************************************************************************************************************************
* @Description    : This method creates number of contacts based on the value in the account filed
* @Param          : No Param
* @Return         : No Return
************************************************************************************************************************************/
    
    public void createNumberOfContacts() {
        
        Map<Id, Decimal> countMap = new Map<Id, Decimal>();
        Map<Id, Decimal> updateMap = new Map<Id, Decimal>();
        for(Account acc : triggerNew) {
            if(acc.NumberofLocations__c != Null) {
                if(Trigger.isUpdate) {
                    if(triggerOldMap.get(acc.id).NumberofLocations__c != acc.NumberofLocations__c) {
                        updateMap.put(acc.Id, acc.NumberofLocations__c - triggerOldMap.get(acc.Id).NumberofLocations__c);
                    }
                } else {
                    countMap.put(acc.Id, acc.NumberofLocations__c);
                }
                
            }
        }
        
        if(!countMap.keySet().isEmpty()) {
            
            creatingContacts(countMap);
        }
        
        //For Handeling update
      
        if(trigger.isUpdate) {
              system.debug(updateMap.keySet());
            if(!updateMap.keySet().isEmpty()) {
                
                for(ID accId : updateMap.keySet()) {
                    
                    if(updateMap.get(accId) > 0) {
                        
                        creatingContacts(updateMap);
                    }
                    
                    if(updateMap.get(accId) < 0) {
                        forDeletingRecords(updateMap);
                    }
                }
            }
        }
        
    }
    
    //For Creating Contacts
    public void creatingContacts(Map<Id, Decimal> countMap) {
        
        List<Contact> contactsToInsert = new List<Contact>();
        for(Id key : countMap.keySet()) {
            if(countMap.get(key) > 0) {
                for(Integer i=1; i<= countMap.get(key); i++) {
                    COntact con = new Contact(AccountID = key, LastName = 'Test Contact ' + i);
                    contactsToInsert.add(con);
                }
            }
            
        }
        if(!contactsToInsert.isEmpty()) {
            try {
                insert contactsToInsert;
            } catch (DMLException e) {
                system.debug(e.getMessage());
            }
        }
    }
    
    //For Deleting Contacts 
    public void forDeletingRecords(Map<Id, Decimal> updateMap) {
        
        if (!updateMap.isEmpty()) {
            List<Contact> contactsToDelete = new List<Contact>();
            for (Id accountId : updateMap.keySet()) {
                
                if(updateMap.get(accountId) < 0) {
                    
                    Integer limitValue = Integer.valueOf(updateMap.get(accountId));                                           
                    Integer absLimitValue = Math.abs(limitValue);                        
                    
                    List<Contact> accountContacts = [
                        							SELECT Id, Name
                        							FROM Contact
                        							WHERE AccountId = :accountId 
                        							LIMIT :absLimitValue
                    								];                    
                    
                    contactsToDelete.addAll(accountContacts);
                    
                }                
            }                        
            if (!contactsToDelete.isEmpty()) {
                try {
                    delete contactsToDelete;
                } catch (DMLException e){
                    system.debug(e.getMessage());
                }
                
            }
        }
        
    }
    
}