public class OrderHandler {
    public static void processOrder(List<Order_Items__c> newItems , List<Order_Items__c> oldItems){
        OrderHelper.processOrderTotals(newItems,oldItems);
    }

}