@isTest
public class StudentHandlerTest {

    @isTest
    static void testCreateStudent() {
        StudentHandler.createStudent('TestStudent', 21);
        Student__c s = [SELECT Student_Name__c, Student_age__c FROM Student__c WHERE Student_Name__c = 'TestStudent' 
                        LIMIT 1];
        System.assertEquals('TestStudent', s.Student_Name__c);
        System.assertEquals(21, s.Student_age__c);
      
    }

    
}