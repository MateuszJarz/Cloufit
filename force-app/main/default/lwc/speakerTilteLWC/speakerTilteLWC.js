import { LightningElement, api, wire } from 'lwc';

import SPEAKER_OBJECT from '@salesforce/schema/Speaker__c';
import SPEAKER_NAME_FIELD from '@salesforce/schema/Speaker__c.Name';
import SPEAKER_EMAIl_FIELD from '@salesforce/schema/Speaker__c.Email__c';
import SPEAKER_URL_FIELD from '@salesforce/schema/Speaker__c.Profile_URL__c';
import SPEAKER_PHONE_FIELD from '@salesforce/schema/Speaker__c.Phone__c';


import { getRecord } from 'lightning/uiRecordApi';

const SPEAKER_FIELDS = [
    'Speaker__c.Name',
    'Speaker__c.Email__c',
    'Speaker__c.Phone__c',
    'Speaker__c.Profile_URL__c',
   
]

export default class SpeakerTilteLWC extends LightningElement {

    @api objectApiName = SPEAKER_OBJECT;
    //@api propertyValue ;
    @api recordId ;


    //@wire(getRecord, { recordId: '$recordId', fields: SPEAKER_FIELDS}) speaker;


   /* get speakerName() {
        return this.speaker.data.fields.Name.value
    }
    get speakerEmail() {
        return this.speaker.data.fields.Email__c.value
    }
    get speakerUrl() {
        return this.speaker.data.fields.Profile_URL__c.value
    }
    get speakerPhone() {
        return this.speaker.data.fields.Phone__c.value
    }*/
  


}