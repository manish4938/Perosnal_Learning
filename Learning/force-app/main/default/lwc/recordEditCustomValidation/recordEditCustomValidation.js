import { LightningElement } from 'lwc';
import  ACCOUNT_OBJECT  from'@salesforce/schema/Account';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class RecordEditCustomValidation extends LightningElement {
    accountObj=ACCOUNT_OBJECT;
    inputValue=''
    handleValidationChange(event){
        this.inputValue=event.target.value;

    }
    handleSubmit(event){
        event.preventDefault();
        const inputField= this.template.querySelector('lightning-input');
        const value=inputField.value;
        if(!value.includes('India')){
            inputField.setCustomValidity("Account Name Must Contain 'India'");
        }else{
            inputField.setCustomValidity("");
            const fields=event.detail.fields;
            fields.Name=value;
            this.template.querySelector('lightning-record-edit-form').submit(fields);
        }
        inputField.reportValidity();


    }
    successHandler(event){
       const totastMsg= new ShowToastEvent({ 
            title:"Account Created",
            message:"Record Id"+ event.detail.id,
            variant:"Success"
         })
         this.dispatchEvent(totastMsg);
    }
}