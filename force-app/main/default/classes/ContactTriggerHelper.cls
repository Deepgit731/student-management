public class ContactTriggerHelper {
    public static void countContact(Map<Id, Contact> newRecordsMap){
        
        Set<Id> accountIdsSet = new Set<Id>();
        for(Contact con: newRecordsMap.values() ){
            if(con.AccountId <> null){ 
                accountIdsSet.add(con.AccountId);
            }
        }
        List<AggregateResult> aggregateList = [SELECT count(Id), AccountId
                                               FROM Contact
                                               WHERE AccountId IN:accountIdsSet
                                               Group By AccountId];
        
        System.debug(aggregateList);
        List<Account> accountListToUpdate = new List<Account>();
        for(AggregateResult ag : aggregateList){
            String accountId = (String)ag.get('AccountId'); 
            Integer totalContact = (Integer)ag.get('expr0'); 
            Account accountRecord = new Account();
            accountRecord.Id = accountId;
            accountRecord.Number_of_Contacts__c = totalContact;
            accountListToUpdate.add(accountRecord);
        }
        update accountListToUpdate;
    }
     public static void markInternalEmployees(List<Contact> contacts) {
        for (Contact c : contacts) {
            if (c.Email != null && c.Email.endsWith('@example.com')) {
                c.Description = 'Internal Employee';
            }
        }
    }
    
/*    public static void stopcontact(List<Contact> contactList){
    Set<Id> accountIds = new Set<Id>();
        
    for (Contact con : contactList) {
        if (con.AccountId != null) {
            accountIds.add(con.AccountId);
        }
    }
    if (!accountIds.isEmpty()) {
        
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();

        for (Account a : [SELECT Id, (SELECT ID FROM Contacts)FROM Account WHERE Id IN :accountIds]) {
            contactCountMap.put(a.ID,a.Contacts.size());
            System.debug(contactCountMap);
        }

        for (Contact con : contactList) {
            
            
         
           // Integer existingContacts = contactCountMap.containsKey(con.AccountId) ? contactCountMap.get(con.AccountId) : 0;
            if(contactCountMap.containsKey(con.AccountId)){
                if(contactCountMap.get(con.AccountId)>=2){
                    con.addError('Each Account can have a maximum of 2 Contacts.');
                    
                }
            }

            if (existingContacts >= 2) {
                con.addError('Each Account can have a maximum of 2 Contacts.');
            }
        }
    }
    }*/
/*    public static void countRelatedContact(List<Contact> contactList){
        Set<Id> accountIds = new Set<Id>();
        
    for (Contact con : contactList) {
        if (con.AccountId != null) {
            accountIds.add(con.AccountId);
        }
    }
    if (!accountIds.isEmpty()) {
        
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
        for (Account a : [SELECT Id, (SELECT ID FROM Contacts)FROM Account WHERE Id IN :accountIds]) {
            contactCountMap.put(a.ID,a.Contacts.size());
            
        }
       
        for (Contact con : contactList){
            
            
        }*/
    
}