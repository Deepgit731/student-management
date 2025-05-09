public with sharing class opportunitiesController {   
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(String accId) {
        try {
            return [
                SELECT Id, Name, AccountId
                FROM Opportunity
                WHERE AccountId = :accId
                WITH SECURITY_ENFORCED
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}