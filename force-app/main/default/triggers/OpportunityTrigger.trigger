trigger OpportunityTrigger on Opportunity (after update) {
    // OpportunityTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
	if(Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
//            OpportunityTriggerHandler.afterUpdateHandler(Trigger.new);
            OpportunityTriggerHandler.afterUpdateHandlerr(Trigger.new,Trigger.oldMap);
        }
    }
}