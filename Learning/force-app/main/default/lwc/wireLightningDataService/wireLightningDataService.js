import { LightningElement, wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import USER_NAME from '@salesforce/schema/User.Name'
import USER_EMAIL from '@salesforce/schema/User.Email';
import USER_PHONE from '@salesforce/schema/User.Phone';

export default class WireLightningDataService extends LightningElement {
     
    userId=Id;
    fields=[USER_NAME, USER_EMAIL, USER_PHONE]
    userData;
    @wire(getRecord, {recordId:'$userId' ,fields:[USER_NAME, USER_EMAIL, USER_PHONE]})
    //Recomended
    userDetailHandler({data,error}){
        if(data){
           this.userData= data.fields;
        }
        if(error){
            console.error(error);
        }
     }
    //Not Recomended 
     @wire(getRecord, {recordId:'$userId', fields:[USER_NAME, USER_EMAIL, USER_PHONE]})
     userDetailProperty

 }