import { LightningElement } from 'lwc';
import Contact_Object from '@salesforce/schema/Contact';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import ACCOUNT_FIELD from '@salesforce/schema/Contact.AccountId';

export default class RecordFormEditOnly extends LightningElement {
   objectname=Contact_Object;
   fieldSet={
            accountField:ACCOUNT_FIELD,
            nameField:NAME_FIELD,
            titleField:TITLE_FIELD,
            phoneField:PHONE_FIELD,
            emailField:EMAIL_FIELD

   }
   handlerReset(){
      const inputFileds=this.template.querySelectorAll('lightning-input-field');
      if(inputFileds){
            Array.from(inputFileds).forEach(field => {
               field.reset();           
            });
      }
   }

}