public with sharing class AccountUpdater {
    @AuraEnabled
    public static void updateAccountIndustry(String accountId, String newIndustry) {
        

        Account acc = [SELECT Id, Industry FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Industry = newIndustry;
        update acc;
    }
}
