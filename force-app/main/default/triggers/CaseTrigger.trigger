trigger CaseTrigger on Case (After insert) {
     CaseTriggerHandler.handleAfterInsert(Trigger.New);
}