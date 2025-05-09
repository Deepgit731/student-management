public class OpportunityTriggerHelper {
     public static void stopopp(List<Opportunity> opportunityList){
    Set<Id> accountIds = new Set<Id>();

    
    for (Opportunity opp : opportunityList) {
        if (opp.AccountId != null) {
            accountIds.add(opp.AccountId);
        }
    }

    if (!accountIds.isEmpty()) {
        
        Map<Id, Integer> opportunityCountMap = new Map<Id, Integer>();

        
        for (Account a : [SELECT Id, (SELECT ID FROM Opportunities)FROM Account WHERE Id IN :accountIds]) {
            opportunityCountMap.put(a.ID,a.Opportunities.size());
        }

        
        for (Opportunity opp : opportunityList) {
            Integer existingOpportunities = opportunityCountMap.containsKey(opp.AccountId) ? opportunityCountMap.get(opp.AccountId) : 0;

            if (existingOpportunities >= 2) {
                opp.addError('Each Account can have a maximum of 2 Opportunity.');
            }
        }
    }
    }
    public static void preventAmountDecreasee(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities){
        String sysAdminProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        for (Opportunity opp : newOpportunities) {
            Opportunity oldOpp = oldOpportunities.get(opp.Id);
            if (opp.Amount < oldOpp.Amount && UserInfo.getProfileId() != sysAdminProfileId) {
                opp.addError('You cannot decrease the Opportunity Amount once it has been set.');
            }
        }
    }
       public static void preventAmountDecrease(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap) {
        String sysAdminProfile = 'System Administrator';
        String currentUserProfile = [SELECT Profile.Name FROM User WHERE Id = :UserInfo.getUserId()].Profile.Name;
        for (Opportunity opp : newOpps) {
            Opportunity oldOpp = oldOppMap.get(opp.Id);
            if (opp.Amount < oldOpp.Amount && currentUserProfile != sysAdminProfile) {
                opp.addError('You cannot decrease the Opportunity Amount once set.');
            }
        }
    }
    public static Map<Id, Opportunity> getOpportunitiesByIds(List<Id> oppIds) {
        if (oppIds == null || oppIds.isEmpty()) {
            return new Map<Id, Opportunity>();
        }
        return new Map<Id, Opportunity>(
            [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE Id IN :oppIds]
        );
    }
    public static Map<Id, Opportunity> getOpp(List<Id> oppIds) {
        return new Map<Id, Opportunity>([SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE Id IN :oppIds]);
    }
    public static void validateOpportunities(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap) {
        for (Opportunity opp : newOpps) {
            Opportunity oldOpp = oldOppMap.get(opp.Id);
            if (opp.CloseDate < Date.today()) {
                opp.addError('Opportunity cannot have a Close Date in the past.');}
            if (oldOpp.StageName == 'Prospecting' && opp.StageName == 'Closed Won') {
                opp.addError('Opportunity cannot transition directly from Prospecting to Closed Won.');}
             if (opp.StageName == 'Closed Won' && opp.Amount < 10000) {
                opp.addError('Opportunities marked as Closed Won must have an Amount of at least $10,000.');
            }
            }  
    }
        public static void handleAfterUpdate(List<Opportunity> newList) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : newList) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        if (accountIds.isEmpty()) {
            return;
        }
        List<Opportunity> relatedOpps = [
            SELECT Id, AccountId, StageName, LastModifiedDate
            FROM Opportunity
            WHERE AccountId IN :accountIds
            ORDER BY LastModifiedDate DESC
        ];
        Map<Id, Opportunity> latestOppByAccount = new Map<Id, Opportunity>();
        for (Opportunity opp : relatedOpps) {
            if (!latestOppByAccount.containsKey(opp.AccountId)) {
                latestOppByAccount.put(opp.AccountId, opp);
            }
        }
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : latestOppByAccount.keySet()) {
            Opportunity latestOpp = latestOppByAccount.get(accId);
            accountsToUpdate.add(new Account(
                Id = accId,
                Latest_Opportunity_Stage__c = latestOpp.StageName
            ));
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
        }
    public static void primaryContact(List<Opportunity> newList, Map<Id, Opportunity> oldOppMap) {
        set<Id> opportunityIds = new Set<Id>();
        for (Opportunity opp : newList) {
            Opportunity oldOpp = oldOppMap.get(opp.Id);
            if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
                opportunityIds.add(opp.Id);
            }
}
        if(!opportunityIds.isEmpty()){
            OpportunityPDFEmailSender.sendPDFEmail(opportunityIds);
        }
    }
}