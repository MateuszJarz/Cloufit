import { LightningElement, wire, api } from 'lwc';

import ATTENDEE_C_OBJECT from '@salesforce/schema/Attendee__c';

import EVENT_NAME_FIELD from '@salesforce/schema/Event__c.Name';
import EVENT_NAMEC_FIELD from '@salesforce/schema/Event__c.Name__c';
import EVENT_LOCATION_FIELD from '@salesforce/schema/Event__c.Location__c';
import EVENT_STARTDATE_FIELD from '@salesforce/schema/Event__c.Start_DateTime__c';
import EVENT_ENDDATE_FIELD from '@salesforce/schema/Event__c.End_DateTime__c';
import EVENT_PEOPLE_FIELD from '@salesforce/schema/Event__c.People_Attending__c';

import getEventListUpComming from '@salesforce/apex/AttendeeEventsController.getEventListUpComming';
import getEventListRelated from '@salesforce/apex/AttendeeEventsController.getEventListRelated';


const columns  = [
    {label: 'Name', fieldName: EVENT_NAME_FIELD.fieldApiName, type: 'text' },
    {label: 'Name__c', fieldName: EVENT_NAMEC_FIELD.fieldApiName, type: 'text' },
    {label: 'Location', fieldName: EVENT_LOCATION_FIELD.fieldApiName, type: 'text' },
    {label: 'Start Date', fieldName: EVENT_STARTDATE_FIELD.fieldApiName, type: 'date' },
    {label: 'End Date', fieldName: EVENT_ENDDATE_FIELD.fieldApiName, type: 'date' },
    {label: 'People_Attending', fieldName: EVENT_PEOPLE_FIELD.fieldApiName, type: 'text' },
   
];

export default class AttendeeEventLWC extends LightningElement {
    columns = columns;
    @api objectApiName = ATTENDEE_C_OBJECT;
    @api recordId;

    @wire(getEventListUpComming, {attendeeId: '$recordId'})
    eventUpComming;

    @wire(getEventListRelated, {attendeeId: '$recordId'})
    eventUpRelated;
}