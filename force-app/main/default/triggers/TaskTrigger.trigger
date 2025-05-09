trigger TaskTrigger on Task (after update) {
       if (Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
            TaskTriggerHandler.afterUpdate(Trigger.oldMap);
        }
    }

}