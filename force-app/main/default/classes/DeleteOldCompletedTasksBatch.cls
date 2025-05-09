global class DeleteOldCompletedTasksBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id FROM Task 
            WHERE Status = 'Completed' 
            AND ActivityDate < :Date.today().addYears(-1)
        ]);
    }
    
    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        delete scope;
    }

    global void finish(Database.BatchableContext bc) {}
}