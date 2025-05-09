@isTest
private class AccountTriggerTest {

    @testSetup
    static void setupData() {
        Account ac = new Account();
        ac.Name = 'test account';
        ac.BillingStreet = 'Main Street';
        //ac.Industry = null;
        ac.BillingCity = 'Alwar';
        ac.BillingState = 'RJ';
        ac.BillingPostalCode = '301001';
        ac.BillingCountry = 'India';
		ac.Email__c = 'test@test.com';
        ac.AnnualRevenue = 6000000;
//        ac.Industry = 'Education';
        insert ac;
    }

    @isTest 
    static void insertAcc(){
        /*List<Account> acc = [select Id , Name,BillingAddress,BillingCity,BillingCountry,ShippingCity from Account ];
        for(Account currentAcc : acc){
           Assert.areEqual(currentAcc.ShippingCity , currentAcc.BillingCity, 'done..');
        }*/
        Account acc = [select Id , Name,BillingAddress,BillingCity,BillingCountry,ShippingCity,Description from Account WHERE Name = 'test account' ];
        Assert.areEqual(acc.ShippingCity , acc.BillingCity, 'done..');
         Assert.areEqual(acc.Description,'Account Industry was blank');
        List<Contact> conList = [SELECT Id, AccountId, LastName FROM Contact];
        System.assertEquals(2, conList.size(), 'One contact should be created per account');
    }
    @isTest
    static void arlimit(){
        
    }
/*@isTest
public class AccountTriggerHelperTest {

    // Utility method to create a test account
/*    private static Account createTestAccount(Boolean withEmail) {
        Account acc = new Account(
            Name = 'Test Account',
            BillingStreet = 'Billing St',
            BillingCity = 'Billing City',
            BillingState = 'Billing State',
            BillingPostalCode = '12345',
            BillingCountry = 'India'
        );
        if (withEmail) {
            acc.Email__c = 'test@example.com'; // Make sure this custom field exists
        }
        return acc;
    }

    @isTest
    static void testUpdateAccountShippingAddress() {
        Account acc = createTestAccount(false);
        acc.ShippingStreet = null; // Force logic to run
        insert acc;

        List<Account> accounts = [SELECT Id, ShippingStreet, BillingStreet, ShippingCity, ShippingCountry FROM Account WHERE Id = :acc.Id];
        AccountTriggerHelper.updateAccountShippingAddress(accounts);

        System.assertEquals('Billing St', accounts[0].ShippingStreet);
    }

    @isTest
    static void testAccountNumber() {
        Account acc = createTestAccount(false);
        insert acc;

        List<Account> accList = new List<Account>{ acc };
        AccountTriggerHelper.accountNumber(accList);

        System.assert(accList[0].Account_Number__c != null, 'Account number should be set');
    }

    @isTest
    static void testCreateContact() {
        Account acc = createTestAccount(false);
        insert acc;

        Test.startTest();
        AccountTriggerHelper.creteContact(new List<Account>{ acc });
        Test.stopTest();

        List<Contact> cons = [SELECT Id FROM Contact WHERE AccountId = :acc.Id];
        System.assertEquals(1, cons.size(), 'One contact should be created');
    }

    @isTest
    static void testAccIndustry() {
        Account acc = new Account(Name = 'Media Account', Industry = 'Media');
        insert acc;

        List<Account> listToUpdate = new List<Account>{ acc };
        AccountTriggerHelper.accindustry(listToUpdate);

        System.assertEquals('hot', listToUpdate[0].Rating, 'Rating should be set to hot for Media industry');
    }

    @isTest
    static void testAnLimitValidation() {
        Account acc = new Account(Name = 'Edu High Rev', Industry = 'Education', AnnualRevenue = 600000);
        insert acc;

        Test.startTest();
        try {
            AccountTriggerHelper.anlimit(new List<Account>{ acc });
            System.assert(false, 'Expected addError to be thrown');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('error'), 'Validation error expected');
        }
        Test.stopTest();
    }*/
/*    @isTest
    static void testAccIndustry() {
        Account acc = new Account(Name = 'Media Co', Industry = 'Media');
        AccountTriggerHelper.accindustry(new List<Account>{ acc });
        System.assertEquals('hot', acc.Rating);
    }
   
    @isTest
    static void testCreteContact() {
        Account testAcc = new Account(Name = 'Test Account ');
        insert testAcc;
        List<Account> accList = [SELECT Id, Name FROM Account WHERE Id = :testAcc.Id];
        AccountTriggerHelper.creteContact(accList);
        Contact con = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId = :testAcc.Id LIMIT 1];
        System.assertNotEquals(null, con, 'Contact should be created');
        System.assertEquals('Test Account create', con.LastName, 'Contact last name should match account name');
    }
    @isTest
    static void testAccountNumber() {
        Account acc = new Account(
            Name = 'Test Account'
        );
        List<Account> accList = new List<Account>{ acc };
        AccountTriggerHelper.accountNumber(accList);
        System.assertNotEquals(null, acc.Account_Number__c, 'Account number should be set');
        System.assert(acc.Account_Number__c.startsWith('Test Account'), 'Account number should start with account name');
    }
        
    @isTest
    static void testSendEmail() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 2; i++) {
            testAccounts.add(new Account(
                Name = 'Test Account ' + i,
                Email__c = 'test' + i + '@example.com'
            ));
        }
        insert testAccounts;

    }
}*/
}