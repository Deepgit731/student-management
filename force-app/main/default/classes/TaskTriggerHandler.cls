public class TaskTriggerHandler {
    public static void afterUpdate(Map<Id,Task> taskMap)
    {
        TaskTriggerHelper.afterUpdateHelper(taskMap);
    }

}