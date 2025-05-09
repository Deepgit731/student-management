public class LeadTriggerHalper {
    public static void createOpportunities(List<Lead> newLeads) {
         List<Opportunity> oppNewList = new List<Opportunity>();
        for(Lead leadOf : newLeads){
            if(leadOf.Status == 'Closed - Converted'){
            Opportunity opp = new Opportunity();
            opp.Name = leadOf.Company; 
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today().addMonths(1);
            opp.LeadSource = leadOf.LeadSource;
            opp.LeadRecordId__c = leadOf.Id;
                
            oppNewList.add(opp);
            }   
        } 
         insert oppNewList;

}
     public static void createLead(List<Lead> newLeads) {
         List<Task> taskNewList = new List<Task>();
        for(Lead leadOf : newLeads){
            if(leadOf.Status == 'Closed - Converted'){
            Task t = new Task();
            t.OwnerId = leadOf.OwnerId; 
            t.Subject = 'ok';
            t.ActivityDate =  leadOf.Follow_Up_Date__c;  
            t.WhoId = leadOf.Id;    
                
            taskNewList.add(t);
            }   
        } 
         insert taskNewList;

}
    public static void sendLeadsToAPI(List<Lead> newLeads) {
        for (Lead l : newLeads) {
            if (l.Name != null && l.Email != null) {
                LeadCalloutService.sendLeadToAPI(l.Name, l.Email);
            }
        }
    }
    public static void handleAfterUpdate(List<Lead> newList, Map<Id, Lead> oldMap) {
        List<Id> convertedLeadIds = new List<Id>();
        
        for (Lead ld : newList) {
            Lead oldLd = oldMap.get(ld.Id);
            if (ld.Status == 'Converted' && oldLd.Status != 'Converted') {
                convertedLeadIds.add(ld.Id);
            }
        }

        if (!convertedLeadIds.isEmpty()) {
            LeadCalloutService.notifyExternalSystem(convertedLeadIds);
        }
    }
}