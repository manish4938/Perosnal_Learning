import { LightningElement, wire } from 'lwc';
import Account_Object from '@salesforce/schema/Account';
import Opp_Object from '@salesforce/schema/Opportunity';
import {getObjectInfo,getObjectInfos} from 'lightning/uiObjectInfoApi';
export default class GetObjectInfoApiPractice extends LightningElement {
     singleObject;
     multipleObject;
     @wire(getObjectInfo,{objectApiName:Account_Object})
    getObjectMetadata({data,error}){
            if(data){
               this.singleObject=data.defaultRecordTypeId;
               console.log(data);
            }
            if(error){

            }
    }
    
    objectApiNames = [Account_Object,Opp_Object]
    @wire(getObjectInfos,{objectApiName:'$objectApiNames'})
    getMulipleObject({data,error}){
        if(data){
            console.log(data);
            this.multipleObject=data.defaultRecordTypeId;
        }
        
    }
}