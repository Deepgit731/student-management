public with sharing class EventController {
   @AuraEnabled(cacheable=true)
public static List<Event__c> getFilteredEvents(String typeFilter, String searchKey) {
    DateTime nowDate = System.now();
    String baseQuery = 'SELECT Id, Name, Event_Date__c, Event_Type__c, Location__c, Description__c, Max__c, Current_Attendees__c FROM Event__c WHERE Event_Date__c >= :nowDate';
    
    if (String.isNotBlank(typeFilter) && typeFilter != 'All') {
        baseQuery += ' AND Event_Type__c = :typeFilter';
    }
    if (String.isNotBlank(searchKey)) {
        String searchPattern = '%' + searchKey + '%';
        baseQuery += ' AND Name LIKE :searchPattern';
    }

    baseQuery += ' ORDER BY Event_Date__c ASC';
    return Database.query(baseQuery);
}

    @AuraEnabled
    public static Boolean checkRegistrationStatus(Id eventId) {
    List<Event_Registration__c> registrations = [
        SELECT Id FROM Event_Registration__c
        WHERE Event__c = :eventId AND Attendee__c = :UserInfo.getUserId() AND Status__c = 'Registered'
        LIMIT 1
    ];
    return !registrations.isEmpty();
}

    @AuraEnabled
    public static void registerUserForEvent(Id eventId) {
        Event__c ev = [SELECT Id, Max__c, Current_Attendees__c FROM Event__c WHERE Id = :eventId];
        if (ev.Current_Attendees__c >= ev.Max__c) {
            throw new AuraHandledException('Event is already full.');
        }
        Boolean alreadyRegistered = ![
            SELECT Id FROM Event_Registration__c 
            WHERE Event__c = :eventId AND Attendee__c = :UserInfo.getUserId() AND Status__c = 'Registered' 
            LIMIT 1
        ].isEmpty();
        if (alreadyRegistered) {
            throw new AuraHandledException('You are already registered for this event.');
        }
        Event_Registration__c reg = new Event_Registration__c(
            Event__c = eventId,
            Attendee__c = UserInfo.getUserId(),
            Status__c = 'Registered',
            Registered_On__c = System.now()
        );
        insert reg;
}

    
    
    @AuraEnabled(cacheable=true)
    public static Boolean isAdminUser() {
        if ([SELECT Profile.Name FROM User WHERE Id = :UserInfo.getUserId()]
            .Profile.Name == 'System Administrator' || FeatureManagement.checkPermission('Event_Management_Admin')) {
            return true;
        }else {
            return false;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Event__c> getEvents() {
        return [
            SELECT Id, Name, Event_Date__c, Event_Type__c, Location__c,
                   Max__c, Current_Attendees__c
            FROM Event__c
            ORDER BY Event_Date__c DESC
        ];
    }

    @AuraEnabled
    public static Event__c saveEvent(Event__c evt) {
        upsert evt;
        return evt;
    }

    @AuraEnabled
    public static void deleteEvent(Id eventId) {
        delete [SELECT Id FROM Event__c WHERE Id = :eventId];
    }
    @AuraEnabled
public static List<Event_Registration__c> getRegistrationsForEvent(Id eventId) {
    return [
        SELECT Id,
               Attendee__c,
               Attendee__r.Name,
               Status__c,
               Registered_on__c
        FROM Event_Registration__c
        WHERE Event__c = :eventId
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
@AuraEnabled
public static void registerForEvent(Id eventId, Id contactId) {
    Event__c eventRecord = [
        SELECT Id, Max__c, Current_Attendees__c
        FROM Event__c
        WHERE Id = :eventId
        LIMIT 1
    ];

    if (eventRecord.Current_Attendees__c >= eventRecord.Max__c) {
        throw new AuraHandledException('Event is full');
    }

    Integer countExisting = [
        SELECT COUNT()
        FROM Event_Registration__c
        WHERE Event__c = :eventId AND Attendee__c = :contactId AND Status__c = 'Registered'
    ];
    if (countExisting > 0) {
        throw new AuraHandledException('You are already registered');
    }

    Event_Registration__c reg = new Event_Registration__c(
        Event__c = eventId,
        Attendee__c = contactId,
        Status__c = 'Registered'
    );
    insert reg;
}
@AuraEnabled
public static List<EventData> getEventStats() {
    List<EventData> data = new List<EventData>();

    // 1. Pehle aggregate query se Event__c ke hisaab se count nikal
    AggregateResult[] groupedResults = [
        SELECT Event__c, COUNT(Id) regCount
        FROM Event_Registration__c
        WHERE Status__c = 'Registered'
        GROUP BY Event__c
    ];

    // 2. Event Ids nikal le
    Set<Id> eventIds = new Set<Id>();
    for (AggregateResult ar : groupedResults) {
        eventIds.add((Id) ar.get('Event__c'));
    }

    // 3. Event__c records le le jisme Name chahiye
    Map<Id, Event__c> eventsMap = new Map<Id, Event__c>(
        [SELECT Id, Name FROM Event__c WHERE Id IN :eventIds]
    );

    // 4. Final list banale jisme Name aur count dono ho
    for (AggregateResult ar : groupedResults) {
        Id eventId = (Id) ar.get('Event__c');
        Integer count = Integer.valueOf(String.valueOf(ar.get('regCount')));
        String eventName = eventsMap.containsKey(eventId) ? eventsMap.get(eventId).Name : 'Unknown Event';

        data.add(new EventData(eventName, count));
    }

    return data;
}

    public class EventData {
        @AuraEnabled public String eventName { get; set; }
        @AuraEnabled public Integer count { get; set; }

        public EventData(String name, Integer count) {
            this.eventName = name;
            this.count = count;
        }
    }
    public static void registerUserForEvent(Id eventId) {
    // your existing logic...

    if (success) {
        Event_Notification__e evt = new Event_Notification__e(
            Message__c = UserInfo.getName() + ' registered for an event!',
            Type__c = 'Info',
            EventId__c = eventId,
            UserName__c = UserInfo.getName()
        );
        EventBus.publish(evt);
    }
}

}
