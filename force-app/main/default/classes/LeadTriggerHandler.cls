public class LeadTriggerHandler {
     public static void handleAfterInsert(List<Lead> newLeads){
            LeadTriggerHalper.createLead(newLeads);
         LeadTriggerHalper.sendLeadsToAPI(newLeads);

}
    public static void handelAfterUpdate(List<Lead> newLeads){
        LeadTriggerHalper.createLead(newLeads);
        
    }
    
    
}