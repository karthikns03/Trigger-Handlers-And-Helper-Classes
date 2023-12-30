public class OpportunityTriggerHandler {
    
    List<Opportunity> triggerNew;
    List<Opportunity> triggerOld;
    Map<Id, Opportunity> triggerNewMap;
    Map<Id, Opportunity> triggerOldMap;
    
    public OpportunityTriggerHandler() {
        triggerNew = (List<Opportunity>)Trigger.New;
        triggerOld = (List<Opportunity>)Trigger.Old;
        triggerNewMap = (Map<Id, Opportunity>)Trigger.NewMap;
        triggerOldMap = (Map<Id, Opportunity>)Trigger.OldMap;
        
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
        
    }
    public void onBeforeUpdate() {
        
    }
    public void onBeforeDelete() {
        
    }
    public void onAfterInsert() {
        createProductForOpportunity();
    }
    public void onAfterUpdate() {
        
    }
    public void onAfterDelete() {
        
    }
    public void onAfterUnDelete() {
        
    }
    
    public void createProductForOpportunity() {
        
        
        List<Product2> product = [Select id, Name from Product2 Limit 1];
        List<PricebookEntry> pricebook = [Select Id, Name from PricebookEntry Limit 1]; 
        List<OpportunityLineItem> proList = new List<OpportunityLineItem>();
        for(Opportunity opp : triggerNew) {
            
            OpportunityLineItem oli = new OpportunityLineItem();
            oli.Product2Id = (!product.isEmpty()) ? product[0].Id : NULL;
            oli.Quantity = 5;
            oli.OpportunityId = opp.Id;
            oli.PricebookEntryId = (!pricebook.isEmpty()) ? pricebook[0].Id : NULL;
            oli.TotalPrice = 50000;
            system.debug(pricebook[0].Id);
            proList.add(oli);
        }
        
        insertOpportunityLineIten(proList);
    }
    
    public void insertOpportunityLineIten(List<OpportunityLineItem> proList) {
        
        if(!proList.isEmpty()) {
            try {
                insert proList;
            } catch (DMLException e) {
                system.debug(e.getMessage());
            }
        }
    }
    
}