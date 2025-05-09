public class OpportunityTriggerHandler {
/*    public static void handleBeforeInsert(List<Opportunity> opportunityList){
        OpportunityTriggerHelper.stopopp(opportunityList);
    }
    public static void handleBeforeUpdate(List<Opportunity> newOpportunities,Map<Id, Opportunity> oldOpportunities){
      //  OpportunityTriggerHelper.stopopp(opportunityList);
        OpportunityTriggerHelper.preventAmountDecrease(newOpportunities,oldOpportunities);
    }
    public static void handleAfterInsert(List<Lead> newLeads, Map<Id, Lead> oldMap){
     OpportunityTriggerHelper.createOpportunities(newLeads, oldMap);   
    }*/
   /* public static void handleBeforeUpdate(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap){
        OpportunityTriggerHelper.preventAmountDecrease(newOpps, oldOppMap);
        OpportunityTriggerHelper.validateOpportunities(newOpps, oldOppMap);*/
        
    
 /*   public static void afterUpdateHandler(List<Opportunity> newList)
    {
        OpportunityTriggerHelper.handleAfterUpdate(newList);
    }*/
    public static void afterUpdateHandlerr(List<Opportunity> newList, Map<Id, Opportunity> oldOppMap){
        OpportunityTriggerHelper.primaryContact(newList,oldOppMap);
    }
}