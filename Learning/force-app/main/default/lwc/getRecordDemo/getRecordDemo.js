import { LightningElement,wire,api } from 'lwc';
import { getRecord, getFieldValue, getFieldDisplayValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name'
import OWNER_FIELD from '@salesforce/schema/Account.Owner.Name'
import AnnualRevenue_FIELD from '@salesforce/schema/Account.AnnualRevenue'
export default class GetRecordDemo extends LightningElement {
    name 
    owner 
    annualRevenue
    @api recordId
    @wire(getRecord,{recordId:'$recordId',
          fields:[NAME_FIELD, OWNER_FIELD, AnnualRevenue_FIELD]})//based on Fileds
     // @api recordId
     // @wire(getRecord,{recordId:'$recordId',layoutTypes:['Full'], modes:['View']})//based on layout
      wireHandler({data, error}){

        if(data){
            console.log(data)
            //this.name = data.fields.Name.value
            //this.annualRevenue = data.fields.AnnualRevenue.value
            //this.owner=data.fields.Owner.value
            this.name=getFieldValue(data,NAME_FIELD)
            this.owner=getFieldValue(data,OWNER_FIELD)
            //this.annualRevenue=getFieldValue(data,AnnualRevenue_FIELD)
            this.annualRevenue=getFieldDisplayValue(data,AnnualRevenue_FIELD)
            
        }

    }
}