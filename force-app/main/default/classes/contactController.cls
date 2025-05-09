public with sharing class contactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContacts(String searchKey) {
        String searchKeyword = '%'+ searchKey.trim() + '%'; 
        
        return [
            SELECT Id, FirstName, LastName FROM Contact WHERE Name LIKE :searchKeyword LIMIT 10];
    }
}