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
       List<Speaker__c> triggerSpeaker =
        new List<Speaker__c>([
            SELECT Id, Name
            FROM Speaker__c 
            WHERE Id IN : triggerSpeakerId]);
    
    
    for(Event_Speaker__c eventSpeaker : eventSpeakersList){
         System.debug('z listy' + eventSpeaker.Speaker__r.Name);
         
         for(Speaker__c trspk : triggerSpeaker){
    		System.debug( 'name of trigger speaker :' + trspk.Name);   
             System.debug( 'name of trigger speaker :' + trspk.Id);    
             if(eventSpeaker.Speaker__r.Name == trspk.Name ){
             
                 for(Event_Speaker__c ev : Trigger.new){
       				ev.addError('Cannot insert duplicate error.');              
                 }
       

            }
    	}
       
     }
    
    
 
}