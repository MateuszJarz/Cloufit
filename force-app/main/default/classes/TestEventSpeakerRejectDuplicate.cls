@isTest
public class TestEventSpeakerRejectDuplicate {
   @isTest public static void testEventSpeakerRejectDuplicate() {
         // Test data setup

         Speaker__c speakerTest1 = new Speaker__c(name = 'test1', Email__c = 'test@gmail.com', Phone__c = '783031293');
         //Speaker__c speakerTest2 = new Speaker__c(name = 'test1', Email__c = 'test@gmail.com', Phone__c = '783031293');
        
         Event__c eventTest1 = new Event__c(name = 'test1', Event_Organizer__c = 'a017S000005WEGJQA4', Name__c ='eventTest1 ',
          Start_DateTime__c = System.today(), Max_Seats__c= 20, End_DateTime__c = System.today().addMonths(1), Live__c = true );
        
        
          insert speakerTest1;
          insert eventTest1;
        Event_Speaker__c evenSpeakerTest1 = new Event_Speaker__c(name = 'sdas', Event__c = eventTest1.id, Speaker__c = speakerTest1.id );
        Event_Speaker__c evenSpeakerTest2 = new Event_Speaker__c(name = 'sdas', Event__c = eventTest1.id, Speaker__c = speakerTest1.id );

         insert evenSpeakerTest1;


          // Perform test
        Test.startTest();

        Database.SaveResult saveResult = Database.insert( evenSpeakerTest2, false);

         Test.stopTest();

         System.assert(!saveResult.isSuccess());
    }
}
