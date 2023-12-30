public class AccountTriggerPractise1Handler {

    List<Account> triggerNew;
    List<Account> triggerOld;
    Map<Id, Account> triggerNewMap;
    Map<Id, Account> triggerOldMap;
    
    public AccountTriggerPRactise1Handler() {
        triggerNew = (List<Account>)Trigger.New;
        triggerOld = (List<Account>)Trigger.Old;
        triggerNewMap = (Map<Id, Account>)Trigger.NewMap;
        triggerOldMap = (Map<Id, Account>)Trigger.OldMap;
          
        doAction();
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
                onAfterUnDelete();
            }
            
        }
    }
    
    public void onBeforeInsert() {
        copyAccountBillingAddressToShippingAddress();
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
    public void onAfterUnDelete() {
        
    }
    
    public void copyAccountBillingAddressToShippingAddress() {
        
        for(Account accRec : triggerNew) {
            if(accRec.ShippingState == NULL && accRec.BillingState != NULL) {
                accRec.ShippingState = accRec.BillingState;
            }
            if(accRec.ShippingStreet == NULL && accRec.BillingStreet != NULL) {
                accRec.ShippingStreet = accRec.BillingStreet;
            }
            if(accRec.ShippingCity == NULL && accRec.BillingCity != NULL) {
                accRec.ShippingCity = accRec.BillingCity;
            }
            if(accRec.ShippingCountry == NULL && accRec.BillingCountry != NULL) {
                accRec.ShippingCountry = accRec.BillingCountry;
            }
            if(accRec.ShippingPostalCode == NULL && accRec.BillingPostalCode != NULL) {
                accRec.ShippingPostalCode = accRec.BillingPostalCode;
            }
            
        }
    }
}