public class ProductTriggerHelper {
    public static void beforeInsertHelper(List<Product2__c> pro)
    {
        Integer randomNumber=(Integer)(Math.random()*10000);
        Date d=Date.today();
        String d2 = String.valueOf(d).replace('-','');
        for (Product2__c p : pro)
        {
            if(p.SKU__c == null)
            {
                p.SKU__c = ('PROD-' + d2 + '-' + randomNumber);
            }
        }
    }

}