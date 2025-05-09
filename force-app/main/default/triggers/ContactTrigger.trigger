trigger ContactTrigger on Contact ( after insert, after update, after delete, after undelete,before insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
            ContactTriggerHandler.handleAfterInsertUpdateUndelete(Trigger.newMap);
        } else if (Trigger.isDelete) {
            ContactTriggerHandler.handleAfterDelete(Trigger.oldMap);
        }
    }
    if (Trigger.isBefore){
        if(trigger.isinsert){
            ContactTriggerHandler.handleBeforeInsert(Trigger.new);                       
        }
    }
}