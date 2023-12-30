/**
 * Day8OpportunityLineItemTriggerHandler
 * 
 * Overview:
 * This class serves as a trigger handler for the OpportunityLineItem object in Salesforce.
 * It is designed to perform specific actions based on different trigger events (insert, update, delete, undelete).
 * The primary purpose is to create assets for OpportunityLineItems associated with an account after insertion.
 * 
 * Trigger Usage:
 * This handler is intended to be used in conjunction with the 'Day8OpportunityLineItemTrigger' trigger,
 * which should be configured to invoke the 'doAction' method in this class.
 * 
 * Methods:
 * - doAction: The main entry point for trigger execution. Calls specific methods based on the trigger operation type.
 * - onBeforeInsert: Placeholder method for actions before OpportunityLineItem records are inserted.
 * - onBeforeUpdate: Placeholder method for actions before OpportunityLineItem records are updated.
 * - onBeforeDelete: Placeholder method for actions before OpportunityLineItem records are deleted.
 * - onAfterInsert: Invoked after OpportunityLineItem records are inserted, triggers 'createaAssetForOliAccount' method.
 * - onAfterUpdate: Placeholder method for actions after OpportunityLineItem records are updated.
 * - onAfterDelete: Placeholder method for actions after OpportunityLineItem records are deleted.
 * - onAfterUnDelete: Placeholder method for actions after OpportunityLineItem records are undeleted.
 * - createaAssetForOliAccount: Queries OpportunityLineItems associated with accounts and triggers asset creation.
 * - creatingAsset: Generates a list of assets to be created based on the provided account IDs.
 * - actuallyCreatingAsset: Attempts to insert the list of assets and handles DML exceptions.
 * 
 * Example Usage:
 * Day8OpportunityLineItemTriggerHandler obj = new Day8OpportunityLineItemTriggerHandler();
 * obj.doAction();
 * 
 * Author: [Your Name]
 * Date: [Current Date]
 * Version: 1.0
 */

public class Day8OpportunityLineItemTriggerHandler {

    List<OpportunityLineItem> triggerNew;
    List<OpportunityLineItem> triggerOld;
    Map<Id, OpportunityLineItem> triggerNewMap;
    Map<Id, OpportunityLineItem> triggerOldMap;

    public Day8OpportunityLineItemTriggerHandler() {        
            triggerNew = (List<OpportunityLineItem>) Trigger.New;
            triggerOld = (List<OpportunityLineItem>) Trigger.Old;
            triggerNewMap = (Map<Id, OpportunityLineItem>) Trigger.NewMap;
            triggerOldMap = (Map<Id, OpportunityLineItem>) Trigger.OldMap;
    }

    public void doAction() {
        switch on Trigger.OperationType {
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

    private void onBeforeInsert() {
        
    }

    private void onBeforeUpdate() {
        
    }

    private void onBeforeDelete() {
        
    }

    private void onAfterInsert() {
        createaAssetForOliAccount();
    }

    private void onAfterUpdate() {
        
    }

    private void onAfterDelete() {
       
    }

    private void onAfterUnDelete() {
        
        
    }
    
    public void createaAssetForOliAccount() {
        
        
        for(OpportunityLineItem oli : triggerNew) {
            system.debug(oli.Quantity);
        }
        
       /* Set<Id> accIds = new Set<Id>();
        List<OpportunityLineItem> oliList = [Select Id, Opportunity.AccountId 
                                             From OpportunityLineItem 
                                             Where Id In: triggerNew 
                                             	   And Opportunity.AccountId != NULL];
        
        for(OpportunityLineItem oli : oliList) {
            accIds.add(oli.Opportunity.AccountId);
        }
        creatingAsset(accIds);
    }
    
    public void creatingAsset(Set<Id> accIds) {
        
        Integer count = 1;
        List<Asset> assetToBeCreated = new List<Asset>();
        for(Id accId : accIds) {
            
            Asset ass = new Asset();
            ass.AccountId = accId;
            ass.Name = 'Asset for Acccount ' + count;
            count += 1;
            assetToBeCreated.add(ass);
        } 
        insertingAssetRecords(assetToBeCreated);  */      
    }
    
    /* public void insertingAssetRecords(List<Asset> assetToBeCreated) {
        
        if(!assetToBeCreated.isEmpty()) {
            try {
                insert assetToBeCreated;
            } catch (DMLException e) {
                system.debug(e.getMessage());
            }
        } 
    } */
}








































/* ========================================FRO NET===========================================================
 * trigger accountRelatedAsset on OpportunityLineItem (after insert){
Set<Id> oppId=new Set<Id>();
for(OpportunityLineItem oppProd:Trigger.new){
oppId.add(oppProd.OpportunityId);
}
List<Asset> assList=new List<Asset>();
List<Opportunity> oppList =[Select Id,AccountId,Account.Name from Opportunity where Id=:oppId];
if(oppList.size()>0){
for(Opportunity opp:oppList){
if(opp.AccountId!=null){
Asset assObj=new Asset();
assObj.Name=opp.Account.Name+' OpportunityLineItem';
assObj.AccountId=opp.AccountId;
assList.add(assObj);
}
}
}
if(assList.size()>0){
insert assList;
}
}

=================================================================FROM CHAT GPT================================================================
trigger Day8OpportunityLineItemTrigger on OpportunityLineItem (after insert) {
    Day8OpportunityLineItemTriggerHandler obj = new Day8OpportunityLineItemTriggerHandler();
    obj.createAssets(Trigger.new);
}

public class Day8OpportunityLineItemTriggerHandler {

    public void createAssets(List<OpportunityLineItem> newOpportunityLineItems) {
        Set<Id> accountIds = new Set<Id>();
        
        for (OpportunityLineItem oli : newOpportunityLineItems) {
            if (oli.Opportunity.AccountId != null) {
                accountIds.add(oli.Opportunity.AccountId);
            }
        }
        
        if (!accountIds.isEmpty()) {
            createAssetsForAccounts(accountIds);
        }
    }

    private void createAssetsForAccounts(Set<Id> accountIds) {
        List<Asset> assetsToBeCreated = new List<Asset>();
        Integer count = 1;

        for (Id accountId : accountIds) {
            Asset newAsset = new Asset(
                AccountId = accountId,
                Name = 'Asset for Account ' + count++
            );
            assetsToBeCreated.add(newAsset);
        }

        actuallyCreateAssets(assetsToBeCreated);
    }

    private void actuallyCreateAssets(List<Asset> assetsToBeCreated) {
        if (!assetsToBeCreated.isEmpty()) {
            try {
                insert assetsToBeCreated;
            } catch (DmlException e) {
                System.debug('Error creating assets: ' + e.getMessage());
                // You might want to log the errors or handle them appropriately
            }
        }
    }
}

 */