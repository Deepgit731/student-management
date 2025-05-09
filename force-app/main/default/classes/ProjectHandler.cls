public class ProjectHandler {
    public static void beforeDelete(List<Project__c> pro){
        ProjectHelper.beforeDeleteHelper(pro);
    }

}