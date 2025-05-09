public class LoanTriggerHandler {
    public static void handleBeforeInsertUpdate(List<Loan_Application__c> loanApps){
        LoanTriggerHelper.validateLoanAmount(loanApps);
    }

}