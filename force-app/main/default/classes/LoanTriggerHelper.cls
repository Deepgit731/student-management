public class LoanTriggerHelper {
    public static void validateLoanAmount(List<Loan_Application__c> loanApps) {
        for (Loan_Application__c loan : loanApps) {
            if (loan.Loan_Amount__c < 5000) {
                loan.addError('Loan Amount must be greater than 5000.');
            }
        }
    }

}