import { LightningElement, wire } from 'lwc';
import { getObjectInfo, getObjectInfos } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity'
export default class GetObjectInfo extends LightningElement {

defaultRecordTypeId
  @wire(getObjectInfo, {objectApiName:ACCOUNT_OBJECT}) //get ObjectInfo is used to fetch the data from one object
  getObjectMetaDataFromSingleObject({data,error}){

    if(data){
        console.log('Test'+data)
        this.defaultRecordTypeId=data.defaultRecordTypeId;
    }
    if(error){
        console.error(error)
    }

  }

//get ObjectInfos is used to fetch the data from one object
objectApiName= [ACCOUNT_OBJECT, OPPORTUNITY_OBJECT]
objectInfos;
@wire(getObjectInfos, {objectApiName:'$objectApiName'})
getObjectMetaDataFromMultiplebject({data,error}){

    if(data){
        console.log('Test'+data)
        this.objectInfos=data;
        
    }
    if(error){
        console.error(error)
    }

  }
}