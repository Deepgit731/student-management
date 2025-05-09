public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getFilteredCases(String status, String priority, String origin) {
        String baseQuery = 'SELECT Id, CaseNumber, Subject, Status, Priority, Origin, Description, CreatedDate, LastModifiedDate, Contact.Name, Account.Name FROM Case WHERE IsDeleted = false';
        
        List<String> conditions = new List<String>();

        if (String.isNotBlank(status)) {
            conditions.add('Status = :status');
        }
        if (String.isNotBlank(priority)) {
            conditions.add('Priority = :priority');
        }
        if (String.isNotBlank(origin)) {
            conditions.add('Origin = :origin');
        }

        if (!conditions.isEmpty()) {
            baseQuery += ' AND ' + String.join(conditions, ' AND ');
        }

        baseQuery += ' ORDER BY CreatedDate DESC';

        return Database.query(baseQuery);
    }

    @AuraEnabled
    public static void deleteCase(Id caseId) {
        try {
            Case c = [SELECT Id FROM Case WHERE Id = :caseId LIMIT 1];
            delete c;
        } catch (Exception e) {
            throw new AuraHandledException('Error deleting case: ' + e.getMessage());
        }
    }
}
