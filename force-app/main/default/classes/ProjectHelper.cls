public class ProjectHelper {
    public static void beforeDeleteHelper(List<Project__c> pro)
    {
        Set<Id> projectIds = new Set<Id>();
    for (Project__c proj : pro) {
        projectIds.add(proj.Id);
    }    
    Integer taskCount = [SELECT COUNT() FROM Task__c WHERE Project__c IN :projectIds];   
    if (taskCount > 0) {
        for (Project__c proj : pro) {
            proj.addError('You cannot delete this Project because related Tasks exist.');
        }
    }
    }

}