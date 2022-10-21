trigger EventSpeakerRejectDuplicate on Event_Speaker__c (before insert, before update ) {

   
     // Get all data 
     List<Event_Speaker__c> eventSpeakersList = new List<Event_Speaker__c>([
        SELECT Id, Speaker__r.Name
        FROM Event_Speaker__c]);
    
	// Get current triggerSpeakerId from Trigger.Now
   	Set<Id> triggerSpeakerId = new Set<Id>();
    String triggerSpeakerId1 = '';
    for(Event_Speaker__c triggerSpeaker : Trigger.new){
      
        if(triggerSpeaker.Speaker__c != null)
        {
            triggerSpeakerId.add(triggerSpeaker.Speaker__c);
           
            System.debug(triggerSpeakerId);
        }
        
    }
    // Query for Speaker Name
       Speaker__c triggerSpeaker =
        [ SELECT Id, Name
          FROM Speaker__c 
          WHERE Id = : triggerSpeakerId];
    
    
    for(Event_Speaker__c eventSpeaker : eventSpeakersList){
         //System.debug('z listy' + eventSpeaker.Speaker__r.Name);
         
         if(eventSpeaker.Speaker__r.Name == triggerSpeaker.Name ){
             
                 for(Event_Speaker__c ev : Trigger.new){
       				ev.addError('Cannot insert duplicate error.');              
                 }
       

            }
    	
       
     }
    
    
 
}