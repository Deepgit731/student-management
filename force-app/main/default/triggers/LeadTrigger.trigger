trigger LeadTrigger on Lead (after insert) {
    if (Trigger.isInsert && Trigger.isAfter) {
        LeadTriggerHandler.handleAfterInsert(Trigger.new);
    }
    if (Trigger.isAfter && Trigger.isUpdate) {
        LeadTriggerHalper.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}