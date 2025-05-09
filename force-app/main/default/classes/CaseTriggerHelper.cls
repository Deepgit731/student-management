public class CaseTriggerHelper {
   /* public static void assignToSupportQueue(List<Case> newCases) {
        Id queueId = [SELECT Id FROM Group WHERE Name = 'Healthcare Sales' AND Type = 'Queue' LIMIT 1].Id;

        List<Case> casesToUpdate = new List<Case>();
        for (Case c : newCases) {
            c.OwnerId = queueId;
            casesToUpdate.add(c);
        }

        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }
    } */
    public static void a(List<Case> newCases){
        system.enqueueJob(new CaseCalloutQueueable());
    }

/*    public static void assignToSupportQueue(List<Case> newCases) {
        Group supportQueue = [SELECT Id FROM Group WHERE Name = 'Healthcare Sales' AND Type = 'Queue' LIMIT 1];
        List<Case> casesToUpdate = new List<Case>();
        for (Case c : newCases) {
            if (c.OwnerId == UserInfo.getUserId()) {  
                Case caseToUpdate = new Case(Id = c.Id, OwnerId = supportQueue.Id);
                casesToUpdate.add(caseToUpdate);
            }
        }
        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }
    }*/
}