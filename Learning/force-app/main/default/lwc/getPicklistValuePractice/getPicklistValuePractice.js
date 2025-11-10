import { LightningElement ,wire} from 'lwc';
import {getObjectInfo, getPicklistValues} from 'lightning/uiObjectInfoApi';
import INUDSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
export default class GetPicklistValuePractice extends LightningElement {

    selectedIndustry=''
    industryOptions=[]
    @wire(getObjectInfo,{objectApiName :ACCOUNT_OBJECT})
    getAccoount;

    @wire(getPicklistValues,{recordTypeId:'$getAccoount.data.defaultRecordTypeId',fieldApiName:INUDSTRY_FIELD})
    getIndustryPicklist({data, error}){
        if(data){
           this.industryOptions=[...this.getPicklistData(data)];
        }
    }

    getPicklistData(data){
       return data.values.map(item => ({label:item.label,value :item.value}));
    }

    industryHandler(event){
        this.selectedIndustry = event.detail.value;
    }
}