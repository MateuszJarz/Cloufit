public with sharing class EventRecordsApexBatchScheduled implements Schedulable {
    
    public void execute(SchedulableContext ctx) {
        EventRecordsApexBatch eventRecordsApexBatch = new EventRecordsApexBatch();
        Id batchId = Database.executeBatch(eventRecordsApexBatch);
    }
}
