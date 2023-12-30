public class ContactTriggerHandlerHelper {

    /*@future
    public static void calculateNumberOfContactsHelper(Id accountId) {

        List<AggregateResult> aggResList = [SELECT COUNT(Id) conCount, AccountId 
                                            FROM Contact 
                                            WHERE AccountId =: accountId
                                            GROUP BY AccountId];

        List<Account> accListToUpdate = countNumberOfRecords(aggResList, accountId);
        updateAccount(accListToUpdate);
    }

    public static List<Account> countNumberOfRecords(List<AggregateResult> aggResList, Id accountId) {

        List<Account> accListToUpdate = new List<Account>();
        Account acc = new Account(Id = accountId);

        if (!aggResList.isEmpty()) {
            for (AggregateResult aggRes : aggResList) {
                acc.Id = accountId;
                acc.Count_of_COntacts__c = (Decimal)aggRes.get('conCount');
                accListToUpdate.add(acc);
            }
        } else {
            acc.Id = accountId;
            acc.Count_of_COntacts__c = null;
            accListToUpdate.add(acc);
        }

        return accListToUpdate;
    }

    public static void updateAccount(List<Account> accListToUpdate) {
        if (!accListToUpdate.isEmpty()) {
            try {
                update accListToUpdate;
            } catch (DMLException e) {
                system.debug(e.getMessage());
            }
        }
    } */
}