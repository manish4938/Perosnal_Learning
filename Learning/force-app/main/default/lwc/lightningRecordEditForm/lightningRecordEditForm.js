import { LightningElement } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact'
import NAME_FIELD from '@salesforce/schema/Contact.Name'
import PHONE_FIELD from '@salesforce/schema/Contact.Phone'
import EMAIL_FIELD from '@salesforce/schema/Contact.Email'
import Account_FIELD from '@salesforce/schema/Contact.AccountId'

export default class LightningRecordEditForm extends LightningElement {
    objectName = CONTACT_OBJECT;
    field ={
        accountField : Account_FIELD,
        nameField : NAME_FIELD,
        phoneField : PHONE_FIELD,
        emailField : EMAIL_FIELD
    }

    cancelHandler(){
        const resetField = this.template.querySelectorAll('lightning-input-field');
        Array.from(resetField).forEach((field) => {
            field.reset();
        });
    }
}