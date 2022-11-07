
global with sharing class EventDetailsRest {

    public static void sendEventDetails() {
        Map<String, Object> json = new Map<String, Object>();

        List<Event__c> eventList =  [
            SELECT Id, Name__c, Start_DateTime__c,End_DateTime__c, Location__c, Event_Organizer__c
            FROM Event__c
            WHERE Live__c = true AND Start_DateTime__c > TODAY
           ];
           
          
           for (Event__c event : eventList) {
            json.put('Id', event.Id);
            json.put('Name', event.Name__c);
            json.put('Start_Date', event.Start_DateTime__c);
            json.put('End_Date', event.End_DateTime__c);
            json.put('Location', event.Location__c);
            json.put('Event_Orgarnizer', event.Event_Organizer__c);
            System.debug(System.JSON.serialize(json)   );
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            // Set the body as a JSON object
            request.setBody(System.JSON.serialize(json));
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if(response.getStatusCode() != 201) {
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
            }
           }
          
       
     
        
    }

}




    /*
   
    @HttpPost
    global static  createEvent() {
        String result = '';
        RestRequest request = RestContext.request;

        Event__c event = [SELECT Id, Event_Detail__c FROM Event__c WHERE Live__c = true AND Start_DateTime__c > TODAY];
        
        System.debug(result);
        
        // Deserialize the JSON string into name-value pairs
        Map<String,String> resultMap = new Map<String,String> {
            'eventId' => event.Id,
            'eventDetail' => event.Event_Detail__c
        };

        result = JSON.serialize(resultMap);
        System.debug(result);

        return result;

        //RestContext.response.addHeader('Content-Type','application/json');
        //RestContext.response.responseBody = Blob.valueOf(result);

        

    }   */
