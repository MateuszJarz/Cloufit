@isTest public class TestEventAttendeeOnNewRecordHandler {
    @isTest public static void testEventAttendeeOnNewRecordHandler() {
      
        Event_Organizer__c  eventOrganizator = new Event_Organizer__c(
          name = 'evebtOrganizator',
           email__c = 'evebtOrganizatorTest@gmail.com',
            phone__c = '781021059');
        insert eventOrganizator; 

        Location__c  locationTest = new Location__c(
          City__c ='Polska',
         Postal_Code__c ='000',
          State__c='test');
        insert locationTest ;
        
        Attendee__c  attendeetest = new Attendee__c(
          name = 'attendeeTest',
          email__c = 'attendeeTest@gmail.com', 
          phone__c = '781021059');
        insert attendeetest; 

        Event__c eventTest = new Event__c(
          name = 'test1', 
          Event_Organizer__c = eventOrganizator.id,
           Name__c ='eventTest11 ',
          Start_DateTime__c = System.today(),
           Max_Seats__c= 20, End_DateTime__c = System.today().addMonths(1),
            Live__c = true, Location__c = locationTest.id);
          insert eventTest ;

       // Start test
        Test.startTest();
        Event_Attendee__c  eventAttendee = new Event_Attendee__c(name = 'eventAttendeeTest', Attendee__c = attendeetest.id, Event__c = eventTest.id);
        insert eventAttendee; 
         Integer emailInvocations = Limits.getEmailInvocations();
      
        Test.stopTest();

        System.assertEquals(1, emailInvocations, 'tesst');
      



        
    }
}
