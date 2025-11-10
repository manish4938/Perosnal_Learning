import { LightningElement, wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry'
import TYPE_FIELD from '@salesforce/schema/Account.Type'
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
export default class GetPickedListValueAdapter extends LightningElement {
    selectedIndustry = '';
    selectedTypes= '';
    indistryOptions=[];
    typeOptions=[];

    @wire(getObjectInfo,{objectApiName:ACCOUNT_OBJECT})
    objectInfo
    
    //First Picklist
    @wire(getPicklistValues,{recordTypeId:'$objectInfo.data.defaultRecordTypeId', fieldApiName:INDUSTRY_FIELD})
    industryPicklistVal({data,error}){
        if(data){
            console.log(data)
    
            this.indistryOptions= [...this.genertaePicklist(data)]
        }
        if(error){
            console.error(error)
        }
    }
   
   //Second Picklist
    @wire(getPicklistValues,{recordTypeId:'$objectInfo.data.defaultRecordTypeId', fieldApiName:TYPE_FIELD})
    typePicklistVal({data,error}){
        if(data){
            console.log(data)
    
            this.typeOptions= [...this.genertaePicklist(data)]
        }
        if(error){
            console.error(error)
        }
    }
    

    genertaePicklist(data){
        return data.values.map(item => ({ label: item.label, value: item.value }))
     }
 
     handleChange(event) {
         this.selectedIndustry = event.detail.value;
     }

     typeHandleChange(event) {
        this.selectedTypes = event.detail.value;
    }
}