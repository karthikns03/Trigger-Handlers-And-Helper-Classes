public class AccountService {
    
    public static void deleteAccountRecords(Integer limitRecords) {
        
        List<Account> accList = [SELECT Id, Name, CreatedDate
                                 FROM Account
                                 WHERE CreatedDate = THIS_YEAR
                                 Order By createdDate desc
                                 Limit :limitRecords
                                ];
        
        if(!accList.isEmpty()) {
             delete accList;
        }
        
    } 
    
}