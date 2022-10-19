public with sharing class ErrorLogHandler {
    
    public static Error_Log__c  insertErrorLog(Datetime  LogDateTime, String LogDetails, String ProcessName ) {
       
        Error_Log__c newErrorLog = new Error_Log__c (
            Log_Date_Time__c = LogDateTime,
            Log_Details__c = LogDetails,
            Process_Name__c = ProcessName
            );

            try {
                insert newErrorLog;
                return newErrorLog;
            } catch (Exception e) {
                return null;
            }
    }
}
