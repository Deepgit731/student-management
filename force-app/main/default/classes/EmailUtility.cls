public class EmailUtility {

    public static void sendEmail(){
       
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject('My First Email From Salesforce');
        
        List<String> toAddress = new List<String>();
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
        toAddress.add('khandelwaldeepanshu19@gmail.com');
//        toAddress.add('jatpariyakanish@gmail.com');

        List<String> bccAddress = new List<String>();
        bccAddress.add('contentlearning222@gmail.com');

        email.setPlainTextBody('Hello Dear, My First Email From Salesforce!');
        email.setToAddresses(toAddress);
        email.setBccAddresses(bccAddress);

        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        emailMessages.add(email);
        List<Messaging.SendEmailResult> sendEmailResults = Messaging.sendEmail(emailMessages, false);
        for(Messaging.SendEmailResult sr: sendEmailResults){ // 10 Emails - 8 Success, 2 Fail
            Boolean isSuccess = sr.isSuccess(); // True OR False
            if(isSuccess){
                System.debug('Email Sent Successfully!!');
            }else{
                System.debug('Error while sending Email \n ');
                List<Messaging.SendEmailError> errors = sr.getErrors();
                System.debug(errors);
            }
        }
        //public Messaging.SendEmailResult[] sendEmail(Messaging.Email[] emails, Boolean allOrNothing)
    }

    
}