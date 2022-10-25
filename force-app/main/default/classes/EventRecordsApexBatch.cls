public with sharing class EventRecordsApexBatch implements Database.Batchable<sObject> {
    
        
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            ' SELECT ID, Name, End_DateTime__c  FROM Event__c WHERE Live__c = TRUE AND End_DateTime__c  < LAST_N_DAYS:60 '
        );
    }
    
    public void execute(Database.BatchableContext bc, List<Event__c> records){
        delete records;
    }
    public void finish(Database.BatchableContext bc){
        
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();

        List<String> sendTo = new List<String>();
        sendTo.add('mateusz.jarzabek@cloobees.com');
        // email body 
        String body = 'Event Records Apex Batch Test';
    
        
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        mail.setToAddresses(sendTo);
        mail.setSubject('Event Records Apex Batch Test');
       
        mail.setHtmlBody(body);
           mails.add(mail);
           Messaging.sendEmail(mails);
    }
}