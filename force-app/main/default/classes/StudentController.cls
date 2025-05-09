public with sharing class StudentController {
    
    @AuraEnabled
    public static List<Student__c> getStudents(String grade) {
        if (String.isNotBlank(grade)) {
            return [SELECT Id, Name, Student_age__c, Grade__c FROM Student__c WHERE Grade__c = :grade];
        }
        return [SELECT Id, Name, Student_age__c, Grade__c FROM Student__c];
    }

  
}
