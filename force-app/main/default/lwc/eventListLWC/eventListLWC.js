import { LightningElement, api, wire, track } from 'lwc';

import getEventList from '@salesforce/apex/EventListController.getEventList';


import EVENT_NAME_FIELD from '@salesforce/schema/Event__c.Name';
import EVENT_NAMEC_FIELD from '@salesforce/schema/Event__c.Name__c';
import EVENT_LOCATION_FIELD from '@salesforce/schema/Event__c.Location__c';
import EVENT_STARTDATE_FIELD from '@salesforce/schema/Event__c.Start_DateTime__c';
import EVENT_ENDDATE_FIELD from '@salesforce/schema/Event__c.End_DateTime__c';
import EVENT_PEOPLE_FIELD from '@salesforce/schema/Event__c.People_Attending__c';

const columns  = [
    {label: 'Name', fieldName: EVENT_NAME_FIELD.fieldApiName, type: 'text' },
    {label: 'Name__C', fieldName: EVENT_NAMEC_FIELD.fieldApiName, type: 'text' },
    {label: 'Location', fieldName: EVENT_LOCATION_FIELD.fieldApiName, type: 'text' },
    {label: 'Start Date', fieldName: EVENT_STARTDATE_FIELD.fieldApiName, type: 'date' },
    {label: 'End Date', fieldName: EVENT_ENDDATE_FIELD.fieldApiName, type: 'date' },
    {label: 'People_Attending', fieldName: EVENT_PEOPLE_FIELD.fieldApiName, type: 'text' },
   
];

export default class EventListLWC extends LightningElement {
    @track data;
    @track error;
    @track columns = columns;
    @track searchString;
    @track initialRecords;
    @track initialRecordsLocation;

   
   
      @wire(getEventList)
      event({ error, data }) {
       if (data) {
           console.log(data);
           this.data = data;
           this.initialRecords = data;
           this.initialRecordsLocation = data;
           this.error = undefined;

           console.info('info',data.fields.Location__c);
       } else if (error) {
           this.error = error;
           this.data = undefined;

       }
    }

    handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();
 
        if (searchKey) {
            this.data = this.initialRecords;
 
            if (this.data) {
                let searchRecords = [];
 
                for (let record of this.data) {
                    let valuesArray = Object.values(record);
 
                    for (let val of valuesArray) {
                        console.log('val is ' + val);
                        let strVal = String(val);
 
                        if (strVal) {
 
                            if (strVal.toLowerCase().includes(searchKey)) {
                                searchRecords.push(record);
                                break;
                            }
                        }
                    }
                }
 
                console.log('Matched Event are ' + JSON.stringify(searchRecords));
                this.data = searchRecords;
            }
        } else {
            this.data = this.initialRecords;
        }
    }
    

   
  


    
}


/*
 handleSearch(event) {
        // Creates the event
        const selectedEvent = new CustomEvent('valueselected', {
            detail: event.detail.value
            
        });
        //dispatching the custom event
        this.dispatchEvent(selectedEvent);
        this.eventOrganizer = event.detail.value[0];
        
        console.info('info',this.eventOrganizer[0]);
        
      
    } */