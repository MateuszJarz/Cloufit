import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import EVENT_C_OBJECT from '@salesforce/schema/Event__c';

import SPEAKER_NAME_FIELD from '@salesforce/schema/Speaker__c.Name';
import SPEAKER_EMAIl_FIELD from '@salesforce/schema/Speaker__c.Email__c';
import SPEAKER_PHONE_FIELD from '@salesforce/schema/Speaker__c.Phone__c';
import SPEAKER_COMPANY_FIELD from '@salesforce/schema/Speaker__c.Company__c';

import ATTENDEE_NAME_FIELD from '@salesforce/schema/Attendee__c.Name';
import ATTENDEE_EMAIl_FIELD from '@salesforce/schema/Attendee__c.Email__c';
import ATTENDEE_PHONE_FIELD from '@salesforce/schema/Attendee__c.Phone__c';
import ATTENDEE_COMPANY_FIELD from '@salesforce/schema/Attendee__c.Company_Name__c';
import ATTENDEE_LOCATION_FIELD from '@salesforce/schema/Attendee__c.Location__c';

import getEventSpeakerById from '@salesforce/apex/EventSpeakerController.getEventSpeakerById';
import getLocationDetails from '@salesforce/apex/EventSpeakerController.getLocationDetails';
import getAttendeesDetails from '@salesforce/apex/EventSpeakerController.getAttendeesDetails';



const FIELDS = [
    'Location__c.City__c',
    'Location__c.Country__c',
    'Location__c.Land_Mark__c',
    'Location__c.Postal_Code__c',
    'Location__c.Street__c',
    'Location__c.State__c',
    'Location__c.Verifed__c',
];

export default class EventDetailLWC extends LightningElement {

    @api objectApiName = EVENT_C_OBJECT;
    //@api propertyValue ;
    @api recordId;

    //Speaker Column
   
    eventAtteendeesColumns  = [
        {label: 'Atteendee Name', fieldName: ATTENDEE_NAME_FIELD.fieldApiName, type: 'text' },
        {label: 'Company', fieldName: ATTENDEE_COMPANY_FIELD.fieldApiName, type: 'text' },
        {label: 'Email', fieldName: ATTENDEE_EMAIl_FIELD.fieldApiName, type: 'email' },
        {label: 'Phone', fieldName: ATTENDEE_PHONE_FIELD.fieldApiName, type: 'phone' },
        {label: 'Location', fieldName: ATTENDEE_LOCATION_FIELD.fieldApiName, type: 'phone' },
   ];

   @wire(getAttendeesDetails, { eventAtteendeeId: '$recordId' })
   atteendee_speaker;
   
   
   //Speaker Column
     eventSpeakerColumns  = [
         {label: 'Speaker Name', fieldName: SPEAKER_NAME_FIELD.fieldApiName, type: 'text' },
         {label: 'Company', fieldName: SPEAKER_COMPANY_FIELD.fieldApiName, type: 'text' },
         {label: 'Email', fieldName: SPEAKER_EMAIl_FIELD.fieldApiName, type: 'email' },
         {label: 'Phone', fieldName: SPEAKER_PHONE_FIELD.fieldApiName, type: 'phone' },
    ];

    @wire(getEventSpeakerById, { eventSpeakerId: '$recordId' })
    event_speaker;

    //Location Column
    @wire(getLocationDetails, { eventId: '$recordId'})
    location_details;
     
    get City__c() {
        return this.location_details.data[0].City__c;
    }
    get Country__c() {
        return this.location_details.data[0].Country__c;
    }
    get Land_Mark__c() {
        return this.location_details.data[0].Land_Mark__c;
    }
    get Postal_Code__c() {
        return this.location_details.data[0].Postal_Code__c;
    }
    get Street__c() {
        return this.location_details.data[0].Street__c;
    }
    get State__c() {
        return this.location_details.data[0].State__c;
    }
    get Verifed__c() {
        return this.location_details.data[0].Verifed__c;
    }
      


}
   
