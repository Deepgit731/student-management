public with sharing class AdminEventController {

    public static Boolean hasAdminPermission() {
        return FeatureManagement.checkPermission('Can_Manage_Events');
    }

    @AuraEnabled
    public static List<Event__c> getAllEvents() {
        if (!hasAdminPermission()) {
            throw new AuraHandledException('Access denied: Missing Can_Manage_Events permission.');
        }

        if (!Schema.sObjectType.Event__c.isAccessible()) {
            throw new AuraHandledException('Permission denied to access Event__c.');
        }

        return [SELECT Id, Name, Event_Date__c, Event_Type__c, Location__c, Description__c,Max__c FROM Event__c];
    }

    @AuraEnabled
    public static void createEvent(Event__c newEvent) {
        if (!hasAdminPermission()) {
            throw new AuraHandledException('Access denied: Missing Can_Manage_Events permission.');
        }

        if (!Schema.sObjectType.Event__c.isCreateable()) {
            throw new AuraHandledException('Create access denied.');
        }

        insert newEvent;
    }

    @AuraEnabled
    public static void updateEvent(Event__c updatedEvent) {
        if (!hasAdminPermission()) {
            throw new AuraHandledException('Access denied: Missing Can_Manage_Events permission.');
        }

        if (!Schema.sObjectType.Event__c.isUpdateable()) {
            throw new AuraHandledException('Update access denied.');
        }

        update updatedEvent;
    }

    @AuraEnabled
    public static void deleteEvent(Id eventId) {
        if (!hasAdminPermission()) {
            throw new AuraHandledException('Access denied: Missing Can_Manage_Events permission.');
        }

        if (!Schema.sObjectType.Event__c.isDeletable()) {
            throw new AuraHandledException('Delete access denied.');
        }

        Event__c eventToDelete = [SELECT Id FROM Event__c WHERE Id = :eventId LIMIT 1];
        delete eventToDelete;
    }
}
