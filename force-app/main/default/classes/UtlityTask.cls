public class UtlityTask {
    public static Map<Id, Integer> ContactCounts(List<Id> accountIds) {
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
        for (AggregateResult ar : [SELECT AccountId accId, COUNT(Id) cnt FROM Contact WHERE AccountId IN :accountIds GROUP BY AccountId]) {
            contactCountMap.put((Id)ar.get('accId'), (Integer)ar.get('cnt'));
        }
        return contactCountMap;

}
}