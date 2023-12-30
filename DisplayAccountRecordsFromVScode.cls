/**
 * @description       : 
 * @author            : Karthik@Kahano.SFDoc
 * @group             : 
 * @last modified on  : 12-20-2023
 * @last modified by  : Karthik@Kahano.SFDoc
**/
public with sharing class DisplayAccountRecordsFromVScode {
    
    public static void displayAccountRecords() {

        List<Account> accList = [SELECT Id, Name, CreatedDate 
        FROM Account With USER_MODE Order By CreatedDate desc 
        LIMIT 20 ];
        for(Account accRec : accList) {
            system.debug(accRec.CreatedDate +' '+ accRec.name);
        }
    }
}