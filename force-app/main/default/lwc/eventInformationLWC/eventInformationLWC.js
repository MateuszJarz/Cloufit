import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';


import EVENT_C_OBJECT from '@salesforce/schema/Event__c';
import NAME_Id from '@salesforce/schema/Event__c.Id';
import NAME_FIELD from '@salesforce/schema/Event__c.Name';
import NAME_FIELD_C from '@salesforce/schema/Event__c.Name__C';
import EVENT_ORGANIZER_FIELD from '@salesforce/schema/Event__c.Event_Organizer__c';
import START_DATE_FIELD from '@salesforce/schema/Event__c.Start_DateTime__c';
import END_DATE_FIELD from '@salesforce/schema/Event__c.End_DateTime__c';
import MAX_ATTENDEES from '@salesforce/schema/Event__c.Max_Seats__c';


export default class EventInformationLWC extends NavigationMixin(LightningElement){
    @api childObjectApiName = 'Event__c'; 
    @api targetFieldApiName = 'Event_Organizer__c'; 
    @api fieldLabel = 'Event Organizer';
    @api disabled = false;
    @api value;
    @api required = false;
    
    fieldValue;

    nameField ;
    nameFieldc ;
    startDateField  ;
    eventOrganizer  ;
    endDateField ;
    maxAttendeField ;
    eventId;

    // startDateField ='2022-01-10T14:53:55.000+0000' ;
    //eventOrganizer = 'a017S000006XE32QAG';

    handleChange(event) {
        // Creates the event
        const selectedEvent = new CustomEvent('valueselected', {
            detail: event.detail.value
            
        });
        //dispatching the custom event
        this.dispatchEvent(selectedEvent);
        this.eventOrganizer = event.detail.value[0];
        
        console.info('info',this.eventOrganizer[0]);
        
      
    }

    @api isValid() {
        if (this.required) {
            this.template.querySelector('lightning-input-field').reportValidity();
        }
    }


    
   handleChangeFields(event){

        this.fieldValue = event.target.value;        
        if(event.target.label === "Name" && this.fieldValue !=='' && this.fieldValue !== undefined){
            this.nameField = this.fieldValue;
           
        }
       else if(event.target.label === "Start Date" && this.fieldValue !=='' && this.fieldValue !== undefined)
           this.startDateField = this.fieldValue;
        else if(event.target.label === "End Date" && this.fieldValue !=='' && this.fieldValue !== undefined)
            this.endDateField = this.fieldValue;   
        else if(event.target.label === "Max Attendees" && this.fieldValue !=='' && this.fieldValue !== undefined)
              this.maxAttendeField = this.fieldValue;        
    }
   
    handleNavigate() {
       
        var compDefinition = {
            componentDef: "c:EventDetailLWC",
            attributes: {
                recordId: this.eventId.id
            }
        };
        // Base64 encode the compDefinition JS object
        var encodedCompDef = btoa(JSON.stringify(compDefinition));
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/one/one.app#' + encodedCompDef
            }
        });

        console.info('info2',this.eventId);

        
    }

 

    createEvent(){


        const FIELDS = {};
        FIELDS[NAME_FIELD.fieldApiName] = this.nameField;
        FIELDS[NAME_FIELD_C.fieldApiName] = this.nameField;
        FIELDS[START_DATE_FIELD.fieldApiName] = this.startDateField;
        FIELDS[END_DATE_FIELD.fieldApiName] = this.endDateField;
        FIELDS[EVENT_ORGANIZER_FIELD.fieldApiName] = this.eventOrganizer;
        FIELDS[MAX_ATTENDEES.fieldApiName] = this.maxAttendeField;

        const recordInput = { apiName: EVENT_C_OBJECT.objectApiName, fields: FIELDS };

        createRecord(recordInput)
            .then(event => {
                
                this.eventId = event;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created',
                        variant: 'success',
                    }),
                    this.handleNavigate()
                );
              
                
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });

            console.info('info2',this.eventId);
            
                   

            
      
    }

    handleFunction(){
        createEvent(function() {
            handleNavigate();
          });
    }

   
  

    


}