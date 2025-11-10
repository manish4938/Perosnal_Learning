import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ANNUALREVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class BaseLightningPractice extends LightningElement {
    ObjectName = ACCOUNT_OBJECT;
    fieldList =[NAME_FIELD,ANNUALREVENUE_FIELD,TYPE_FIELD,INDUSTRY_FIELD]
    successHandler(event){
        console.log('Record Id '+event.detail.id);
        const dispEvent=new ShowToastEvent({
             title:'Account Created',
             message:'Created Account Id Is :'+event.detail.id,
             variant:'success'
            })
        this.dispatchEvent(dispEvent);
    }
    
}