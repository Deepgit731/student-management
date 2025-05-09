trigger LoanTrigger on Loan_Application__c (before insert,before update) {
    LoanTriggerHandler.handleBeforeInsertUpdate(Trigger.New);
    
}