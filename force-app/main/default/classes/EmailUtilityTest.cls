@IsTest
public class EmailUtilityTest {
    @isTest
    static void testSendEmail() {
        Test.startTest();        
        EmailUtility.sendEmail();
        Test.stopTest();        
//        System.assert(true, 'Email method executed without exceptions.');
    }
}