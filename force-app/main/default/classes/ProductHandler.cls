public class ProductHandler {
    public static void beforeInsertHandler(List<Product2__c> pro){
        ProductTriggerHelper.beforeInsertHelper(pro);
    }

}