import { LightningElement,wire } from 'lwc';
import fliterAccountsByType from '@salesforce/apex/AccountController.fliterAccountsByType'
export default class GetAccountDataByType extends LightningElement {
    selectedType='';
    @wire(fliterAccountsByType, {type:'$selectedType'})
    filteredAccounts
    
    get typeOption(){
      return [
        {label:"Customer - Channel", value:"Customer - Channel"},
        {label:"Customer - Direct", value:"Customer - Direct"}
      ] 
    }

    getAccountTypeHandler(event){
       this.selectedType= event.target.value;
    }
}