public with sharing class accountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getLatestAccounts(){
        try {
            return [SELECT Id,Industry, Name, CreatedDate FROM Account ORDER BY CreatedDate DESC LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching accounts: ' + e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static void updateAccountIndustry(String accountId, String newIndustry) {
        if (String.isBlank(accountId) || String.isBlank(newIndustry)) {
            throw new AuraHandledException('Account ID and Industry must not be empty.');
        }
    
        try {
            Account acc = [SELECT Id, Industry FROM Account WHERE Id = :accountId LIMIT 1];
            acc.Industry = newIndustry;
            update acc;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating industry: ' + e.getMessage());
       }
        }
        

    @AuraEnabled(cacheable=true)
    public static List<Account> fetchAccounts(String searchKey){
        String searchKeyword =  searchKey.trim() + '%';
        return[SELECT Id,Name,Industry,Phone FROM Account WHERE Name LIKE :searchKeyword LIMIT 10];
    }
}

    

