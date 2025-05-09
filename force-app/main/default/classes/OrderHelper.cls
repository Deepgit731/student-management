public class OrderHelper {
     public static void processOrderTotals(List<Order_Items__c> newItems , List<Order_Items__c> oldItems)
    {
        Set<Id> orderIds = new Set<Id>();

        
        if (newItems != null) {
            for (Order_Items__c item : newItems) {
                if (item.Orders__c != null) {
                    orderIds.add(item.Orders__c);
                }
            }
        }

        
        if (oldItems != null) {
            for (Order_Items__c item : oldItems) {
                if (item.Orders__c != null) {
                    orderIds.add(item.Orders__c);
                }
            }
        }

        if (!orderIds.isEmpty()) {
            updateOrderTotals(orderIds);
        }
    }

    private static void updateOrderTotals(Set<Id> orderIds) {
        
        Map<Id, Decimal> orderTotals = new Map<Id, Decimal>();

       
        for (AggregateResult ar : [
            SELECT Orders__c, SUM(Item_Price__c) total
            FROM Order_Items__c
            WHERE Orders__c IN :orderIds
            GROUP BY Orders__c
        ]) {
            orderTotals.put((Id) ar.get('Orders__c'), (Decimal) ar.get('total'));
        }

      
        List<Order__c> ordersToUpdate = new List<Order__c>();
        for (Id orderId : orderIds) {
            ordersToUpdate.add(new Order__c(
                Id = orderId,
                Total_Order_Value__c = orderTotals.containsKey(orderId) ? orderTotals.get(orderId) : 0
            ));
        }

        
        if (!ordersToUpdate.isEmpty()) {
            update ordersToUpdate;
        }
    }

}