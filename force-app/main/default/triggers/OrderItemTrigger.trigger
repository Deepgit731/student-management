trigger OrderItemTrigger on Order_Items__c (after insert, after update, after delete, after undelete) {
     if(Trigger.isAfter)
    {
        OrderHandler.processOrder(Trigger.new , Trigger.old);
    }
}