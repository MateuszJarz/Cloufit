trigger CalloutToSmartyStreetsTrigger on Location__c (before insert, before update) {

    for (Location__C loc : Trigger.New) {
        
        if (loc.Country__c == 'USA') {
            
           /* CalloutToSmartyStreets.calloutToVerifyLocation(
                loc.city__c,
                loc.state__c,
                loc.street__c,
            loc.Postal_Code__c);*/

            CalloutToSmartyStreets.doFuture(loc.id);
            
             loc.Verified__c = true;
            
          
            
        }
    }
  

}