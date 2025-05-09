trigger ProjectTrigger on Project__c (before delete) {
      if(Trigger.isBefore)
    {
        if(Trigger.isDelete)
        {
            ProjectHandler.beforeDelete(Trigger.old);
        }
    }

}