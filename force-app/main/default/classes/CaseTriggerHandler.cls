public class CaseTriggerHandler {
    public static void handleAfterInsert(List<Case> newCases) {
        CaseTriggerHelper.a(newCases);
    }

}