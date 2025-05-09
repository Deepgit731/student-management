public class StudentHandler {
    public  static void createStudent(String name, Integer age){
        Student__c s = new Student__c();
        s.Student_Name__c = name;
        s.Student_age__c = age;
        s.Student_Email__c = name +'34@gmail.com';
        s.Mobile_No__c = 12345678;
        insert s;
        
    }
    
}