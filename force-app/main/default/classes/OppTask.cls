public class OppTask {
    public static Map<Id, Opportunity> getOpportunitiesByIds(List<Id> oppIds) {
        return new Map<Id, Opportunity>(
            [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE Id IN :oppIds]
        );
    }

}