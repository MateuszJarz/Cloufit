public with sharing class EventListController {
   
   
    @AuraEnabled(cacheable=true)
    public static list<Event__c> getEventList() {
        
      

       // create contact list to store search result 
        list<Event__c> eventListRecord = [SELECT id,Name,Location__c,Start_DateTime__c,End_DateTime__c,People_Attending__c
        From Event__c];
     
	   // query contact records
        /*for(contact conObj : [Select id,Name,Email,FirstName,LastName,Phone
                            From Contact
                            WHERE name LIKE : searchKeyword]){
           contactListRecord.add(conObj);
        }
        
         if(contactListRecord.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }*/
         
        return eventListRecord;
    }
}
