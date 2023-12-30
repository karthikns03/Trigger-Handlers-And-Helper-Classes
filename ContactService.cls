public class ContactService {
    
    public Static void deleteContactsLastYear(Integer limitRecords) {
        
        List<Contact> conList = [Select Id, name 
                                 From Contact
                                 Where createdDate = LAST_N_YEARS:1
                                 Limit :limitRecords];
        
        if(!conList.isEmpty()) {
            delete conList;
        }        
    }
}