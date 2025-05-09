trigger Product on Product2__c (before insert) {
	
	if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            ProductHandler.beforeInsertHandler(Trigger.new);
        }
    }
}