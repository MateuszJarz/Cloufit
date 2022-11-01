public with sharing class EventSpeakerController {
        
    
    @AuraEnabled(cacheable=true)
    public static List<Speaker__c> getEventSpeakerById(id eventSpeakerId) {
       
             Set<Id> speakersId = new Set<Id>();
 
        
            for (Event_Speaker__c event_speaker : [
                SELECT Id, Speaker__r.id 
                FROM Event_Speaker__c
                WHERE Event__r.id =: eventSpeakerId   
            ]) {
            
                speakersId.add(event_speaker.Speaker__r.id);
                System.debug(speakersId);
            }

            List<Speaker__c> speakers =  [
                SELECT Id, Name, Email__c, Phone__c,Company__c
                FROM Speaker__c
                WHERE Id IN : speakersId];
       
         System.debug(speakers);
         return speakers;
    }
       

        @AuraEnabled(cacheable=true)
        public static  List<Location__c> getLocationDetails(string eventId) {
            
            Set<Id> locationId = new Set<Id>();

            System.debug(eventId);
            for (Event__c event : [
                SELECT Id, Location__r.id
                FROM Event__c
                WHERE id = : eventId    
            ]) {
            
                locationId.add(event.location__r.id);
                System.debug(locationId);
            }

    
           List<Location__c> location =  [
             SELECT Id, City__c, Country__c, Land_Mark__c, Postal_Code__c, State__c,Street__c,Verified__c
             FROM Location__c
             WHERE id IN :locationId
             ];

             System.debug(location);
             //System.debug(test);
             return location;
                
    }

     @AuraEnabled(cacheable=true)
     public static List<Attendee__c> getAttendeesDetails(id eventAtteendeeId) {
        
              Set<Id> attendeeId = new Set<Id>();
  
         
             for (Event_Attendee__c event_attendee : [
                 SELECT Id, Attendee__r.id
                 FROM Event_Attendee__c
                 WHERE Event__r.id =: eventAtteendeeId   
             ]) {
             
                attendeeId.add(event_attendee.Attendee__r.id);
                 System.debug(attendeeId);
             }
 
             List<Attendee__c> attendee =  [
                 SELECT Id, Name, Email__c, Phone__c, Company_Name__c,Location__c
                 FROM Attendee__c
                 WHERE Id IN : attendeeId];
        
          System.debug(attendee);
          return attendee;
    }
        

}



     /**     List<Speaker__c> test =  [
            SELECT Id, Name ,(SELECT id, Speaker__c FROM Event_Speaker__r  WHERE Event__c =: eventSpeakerId)
            FROM Speaker__c
            
             List<Speaker__c> speakers =  [
            SELECT Id, Name ,(SELECT id, Speaker__c FROM Event_Speaker__r  WHERE Event__c =: eventSpeakerId)
            FROM Speaker__c];
       ]; */


//a007S0000031DFvQAM