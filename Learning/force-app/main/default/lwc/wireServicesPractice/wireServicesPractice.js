import { LightningElement ,wire} from 'lwc';
import Id from '@salesforce/user/Id'
import USERNAME_FIELD from '@salesforce/schema/User.Name'
import USEREMAIL_FIELD from '@salesforce/schema/User.Email'
import {getRecord} from 'lightning/uiRecordApi'
const fields=[USERNAME_FIELD,USEREMAIL_FIELD]
export default class WireServicesPractice extends LightningElement {

 
    userId=Id;
    userDetails
    @wire(getRecord,{recordId:'$userId', fields})
    handleUserDeatils({data,error}){
        if(data){
            this.userDetails= data.fields;
        }
        if(error){
              console.log(error);
        }
       
    }
}