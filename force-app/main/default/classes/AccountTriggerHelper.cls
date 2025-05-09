public class AccountTriggerHelper {
    public static void updateAccountShippingAddress(List<Account> accountList){
        for(Account acc : accountList){ 
            if(acc.Industry == null){
                acc.Description = 'Account Industry was blank';
            }
            if(acc.ShippingStreet == null || acc.ShippingCity == null || acc.ShippingState == null || acc.ShippingPostalCode == null || acc.ShippingCountry == null){
                acc.ShippingStreet         = acc.BillingStreet; 
                acc.ShippingCity         = acc.BillingCity;
                acc.ShippingState         = acc.BillingState;
                acc.ShippingPostalCode  = acc.BillingPostalCode;
                acc.ShippingCountry     = acc.BillingCountry;
            }
        }
    }
    public static void anlimit(List<Account> accountList){
        for(Account acc :accountlist){
            if(acc.AnnualRevenue>500000 && acc.Industry=='Education'){
                acc.addError('error');
            }
            
        }
    }
    public static void accindustry(list<Account> accountlist){
        for(Account acc :accountList){
            if(acc.Industry != null && acc.Industry == 'Media')
            {
                acc.Rating ='hot';
            }        
    }
        
    }
    public static void creteContact(list<Account> accountlist){
        list<Contact> conToBeInsert = new list<Contact>();
        
        for (Account acc : accountlist){
            Contact con = new Contact();
            con.LastName = acc.Name;
            con.AccountId = acc.Id;
            conToBeInsert.add(con);   
        }
        if(!conToBeInsert.isEmpty()){
            insert conToBeInsert;
        }
    }
    public static void accountNumber(list<Account> accountlist){
        for (Account acc : accountlist){
            acc.Account_Number__c = acc.Name + string.valueof(System.currentTimeMillis());
            
        }
    }
    public static void sendEmail(List<Account> accountlist){        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (Account acc : accountlist){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{ acc.Email__c });
            email.setSubject('Your Account Has Been Created');
            email.setPlainTextBody('Hello ' );
            emails.add(email);    
    	}
        Messaging.sendEmail(emails);
	}
}