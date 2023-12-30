public class Day7OpportunityLineItemTriggerHandler {
    
    List<OpportunityLineItem> triggerNew;
    List<OpportunityLineItem> triggerOld;
    Map<Id, OpportunityLineItem> triggerNewMap;
    Map<Id, OpportunityLineItem> triggerOldMap;
    
    
    List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
    //Global Email Set
    List<String> emailList = new List<String>();
    
    public Day7OpportunityLineItemTriggerHandler() {
        
        triggerNew = (List<OpportunityLineItem>)Trigger.New;
        triggerOld = (List<OpportunityLineItem>)Trigger.Old;
        triggerNewMap = (Map<Id, OpportunityLineItem>)Trigger.NewMap;
        triggerOldMap = (Map<Id, OpportunityLineItem>)Trigger.OldMap;
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
                oAfterUndelete();
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
    
    public void oAfterUndelete() {
        
    }
    
    public void sendEmailToCLientContact() {
        
        Set<Id> accIds = new Set<Id>();
        
        oliList = [SELECT Id, Name, Opportunity.AccountId, ProductCode, UnitPrice, ListPrice
                   FROM OpportunityLineItem 
                   Where Opportunity.AccountId != NULL And Id In : triggerNew];
        
        for(OpportunityLineItem oli : oliList) {
            accIds.add(oli.Opportunity.AccountId);                      
        }
        
        if(!accIds.isEmpty()) {
            
            List<Account> accList = [Select Id, Name, Client_Contact__r.Email from Account Where Id In : accIds]; 
            
            for(Account accRec : accList) {
                emailList.add(accRec.Client_Contact__r.Email);
            }
        }       
    }
    
    public void consTructEmail() {
        
        List<String> toAddress = emailList;
        String Subject = 'An OpportunityLine Item Created';
            }
}

/*trigger sendEmailToContact on OpportunityLineItem (after insert){
Set<Id> oppId =new Set<Id>();
String userName;
Map<Id,Opportunity> oppIdConEmailMap = new Map<Id,Opportunity>();
for(OpportunityLineItem oppProd:Trigger.new){
oppId.add(oppProd.OpportunityId);
userName=oppProd.CreatedBy.Name;
}
List<Opportunity> oppList=[Select Id,Account.Client_Contact__r.Email,Account.Client_Contact__r.LastName,Account.Client_Contact__c From Opportunity where Id=:oppId];
if(oppList.size()>0){
for(Opportunity opp:oppList){
oppIdConEmailMap.put(opp.Id,opp);

}
}
List<Messaging.SingleEmailMessage> emailList= new List<Messaging.SingleEmailMessage>();
for(OpportunityLineItem oppProd:Trigger.new){
if(oppIdConEmailMap.containsKey(oppProd.OpportunityId)){
Opportunity oppObj=oppIdConEmailMap.get(oppProd.OpportunityId);
String sendTo=oppObj.Account.Client_Contact__r.Email;
if(sendTo!=null){
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setTargetObjectId(oppObj.Account.Client_Contact__c);
mail.setSenderDisplayName('System Administrator');
mail.setUseSignature(false);
mail.setBccSender(false);
mail.setSaveAsActivity(false);
mail.setSubject('New Opportunity Product was Created.');
String body = 'Dear '+oppObj.Account.Client_Contact__r.LastName+', <br/>';
body += 'Your Order has been proceed.<br/>';
body +='Order detail is below.<br/>';
body +='Product Name : '+oppProd.Name+'.<br/>';
body +='Product Code : '+oppProd.ProductCode+'.<br/>';
body +='Unit Price : '+oppProd.UnitPrice+'.<br/>';
body +='List Price : '+oppProd.ListPrice+'.<br/>';
body +='Thanks <br/>'+userName;
mail.setHtmlBody(body);
mail.toAddresses = new String[]{sendTo};
emailList.add(mail);
}
}
}
if(emailList.size()>0){
Messaging.SendEmailResult[] results = Messaging.sendEmail(emailList);
if (results[0].success)
{
System.debug('The email was sent successfully.');
} else {
System.debug('The email failed to send: '+ results[0].errors[0].message);
}
}
}
 */