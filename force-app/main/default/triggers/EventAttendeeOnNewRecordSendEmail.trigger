trigger EventAttendeeOnNewRecordSendEmail on Event_Attendee__c (after insert) {
	EventAttendeeOnNewRecordSendEmailHandler ea = new EventAttendeeOnNewRecordSendEmailHandler();
    try {
        ea.sendEmailHandler(Trigger.new);

    } catch (Exception ex) {
        system.debug(ex.getMessage());
    } 
    

}