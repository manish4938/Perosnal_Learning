import { LightningElement,wire } from 'lwc';
import { getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import ACCOUINT_OBJECT from '@salesforce/schema/Account'
export default class GetPicklistValueByRecordTypeDemo extends LightningElement {
    ratingOption
    industryOption
    selectedRating
    selectedIndustry

    @wire(getObjectInfo, {objectApiName:ACCOUINT_OBJECT})
    objectInfo
    
    @wire(getPicklistValuesByRecordType,{objectApiName:ACCOUINT_OBJECT, recordTypeId:'$objectInfo.data.defaultRecordTypeId'})
    getPicklistValues({data,error}){
        if(data){
            console.log(data)
             this.ratingOption = this.picklistGenerator(data.picklistFieldValues.Rating)
             this.industryOption= this.picklistGenerator(data.picklistFieldValues.Industry)
        }
        if(error){
              console.error(error)
        }
    }

    picklistGenerator(data){
        return data.values.map(item => ({"label":item.label, "value":item.value}))
    }

    handleChange(event){
      console.log(event.target.name +'==> '+ event.target.value)
      if(event.target.name === 'rating'){
        this.selectedRating = event.target.value
      }

      if(event.target.name === 'industry'){
        this.selectedIndustry = event.target.value
      }
    }
    
}