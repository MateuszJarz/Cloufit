public with sharing class AttendeeEventsController {
    @AuraEnabled(cacheable=true)
    
    public static list<Event__c> getEventListUpComming(String attendeeId) {
        
        Set<Id> eventId = new Set<Id>();

        for (Event_Attendee__c event_attendee : [
                 SELECT Id, Event__r.id
                 FROM Event_Attendee__c
                 WHERE Attendee__r.id =: attendeeId 
             ]) {
             
                eventId.add(event_attendee.Event__r.id);
                 System.debug(attendeeId);
             }

             List<Event__c> events =  [
                SELECT id,Name,Location__c,Start_DateTime__c,End_DateTime__c,People_Attending__c
                FROM Event__c
                WHERE Id IN : eventId AND Start_DateTime__c > TODAY];

                return events;

        
    }
    @AuraEnabled(cacheable=true)
    public static list<Event__c> getEventListRelated(String attendeeId) {
        
        Set<Id> eventId = new Set<Id>();

        for (Event_Attendee__c event_attendee : [
                 SELECT Id, Event__r.id
                 FROM Event_Attendee__c
                 WHERE Attendee__r.id =: attendeeId 
             ]) {
             
                eventId.add(event_attendee.Event__r.id);
                 System.debug(attendeeId);
             }

             List<Event__c> events =  [
                SELECT id,Name,Location__c,Start_DateTime__c,End_DateTime__c,People_Attending__c
                FROM Event__c
                WHERE Id IN : eventId AND End_DateTime__c < TODAY];

                return events;

        
    }
}
