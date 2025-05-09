public class ContactTriggerHandler {
    private static Boolean hasRun = false;
    public static void handleAfterInsertUpdateUndelete(Map<Id, Contact> newRecordsMap) {
        ContactTriggerHelper.countContact(newRecordsMap);
    }

    public static void handleAfterDelete(Map<Id, Contact> newRecordsMap) {
        ContactTriggerHelper.countContact(newRecordsMap);
    }
     public static void handleBeforeInsert(List<Contact> contacts) {
        ContactTriggerHelper.markInternalEmployees(contacts);
    }
}
    
/*    public static void handleBeforeInsert(List<Contact> contactList){
        ContactTriggerHelper.stopcontact(contactList);
    }
    public static void handleAfterUpdate(Map<Id, Contact> newRecordsMap,Map<Id, Contact> oldRecordsMap){
        ContactTriggerHelper.stopcontact(contactList);
        ContactTriggerHelper.countContact(newRecordsMap);
    }

    public static void handleAfterInsert(Map<Id, Contact> newRecordsMap){
        ContactTriggerHelper.countContact(newRecordsMap);
    }
    public static void handleAfterUndelete(Map<Id, Contact> newRecordsMap){
        ContactTriggerHelper.countContact(newRecordsMap);
    }
    public static void handleAfterDelete(Map<Id, Contact> oldRecordsMap){
        ContactTriggerHelper.countContact(oldRecordsMap);
    }
    public static void handleAfterUpdate(Map<Id, Contact> newRecordsMap, Map<Id, Contact> oldRecordsMap){
        Set<Id> accountIdsSet = new Set<Id>();
        for(Contact newRecord : newRecordsMap.values() ){
            Contact oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.AccountId <> newRecord.AccountId){
                accountIdsSet.add(oldRecord.AccountId); // ABC
                accountIdsSet.add(newRecord.AccountId); // XYZ
            }
        }
        List<AggregateResult> aggregateList = [SELECT count(Id), AccountId
                                               FROM Contact
                                               WHERE AccountId IN:accountIdsSet
                                               Group By AccountId];

        List<Account> accountListToUpdate = new List<Account>();
        for(AggregateResult ag : aggregateList){
            String accountId = (String)ag.get('AccountId'); // Object
            Integer totalContact = (Integer)ag.get('expr0'); // Object
            Account accountRecord = new Account();
            accountRecord.Id = accountId;
            accountRecord.Number_of_Contacts__c = totalContact;
            accountListToUpdate.add(accountRecord);
        }
        update accountListToUpdate;
    }
}
    
    
}*/