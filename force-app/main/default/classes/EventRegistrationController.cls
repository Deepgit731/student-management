public with sharing class EventRegistrationController {
    @AuraEnabled(cacheable=true)
    public static List<Event__c> getAvailableEvents() {
        return [SELECT Id, Name, Event_Date__c FROM Event__c WHERE Event_Date__c >= :System.now()];
    }

    @AuraEnabled
    public static void registerForEvent(Id eventId) {
        Id currentUserId = UserInfo.getUserId();

        // Check for existing registration
        List<Event_Registration__c> existing = [
            SELECT Id FROM Event_Registration__c 
            WHERE Event__c = :eventId AND Attendee__c = :currentUserId AND Status__c = 'Registered'
        ];
        if (!existing.isEmpty()) {
            throw new AuraHandledException('You have already registered for this event.');
        }

        // Create new registration
        Event_Registration__c reg = new Event_Registration__c(
            Event__c = eventId,
            Attendee__c = currentUserId,
            Status__c = 'Registered'    
        );
        insert reg;
    }
    @AuraEnabled(cacheable=true)
    public static List<Event_Registration__c> getMyRegistrations() {
        return [
            SELECT Id, Event__r.Name, Event__r.Event_Date__c, Event__r.Location__c, Status__c
            FROM Event_Registration__c
            WHERE Attendee__c = :UserInfo.getUserId()
            AND Status__c = 'Registered'
            ORDER BY Event__r.Event_Date__c ASC
        ];
    }
    @AuraEnabled
public static void deleteRegistration(Id registrationId) {
    Event_Registration__c reg = [SELECT Id FROM Event_Registration__c WHERE Id = :registrationId LIMIT 1];
    delete reg;
}
@AuraEnabled
public static void cancelRegistration(Id registrationId) {
    Event_Registration__c reg = [SELECT Id, Status__c FROM Event_Registration__c WHERE Id = :registrationId LIMIT 1];
    reg.Status__c = 'Cancelled'; 
    update reg;
}
 @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getDateWiseRegistrations() {
        Map<String, Integer> result = new Map<String, Integer>();
        for (AggregateResult ar : [
            SELECT DAY_ONLY(Registered_on__c) regDate, COUNT(Id) regCount
            FROM Event_Registration__c
            GROUP BY DAY_ONLY(Registered_on__c)
            ORDER BY DAY_ONLY(Registered_on__c)
        ]) {
            Date dateVal = (Date) ar.get('regDate');
            result.put(String.valueOf(dateVal), (Integer) ar.get('regCount'));
        }
        return result;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getEventWiseRegistrations() {
        Map<String, Integer> result = new Map<String, Integer>();
        for (AggregateResult ar : [
            SELECT Event__r.Name eventName, COUNT(Id) regCount
            FROM Event_Registration__c
            GROUP BY Event__r.Name
        ]) {
            result.put((String) ar.get('eventName'), (Integer) ar.get('regCount'));
        }
        return result;
    }
    
    
}
