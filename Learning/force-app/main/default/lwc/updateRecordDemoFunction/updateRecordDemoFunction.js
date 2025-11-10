import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import { updateRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact'
const cols=[
    {label:'Id', fieldName:'Id'},
    {label:'Name', fieldName:'Name'},
    {label:'Title', fieldName:'Title'},
    {label:'Phone', fieldName:'Phone', editable:true},
    {label:'Email', fieldName:'Email', type:'email', editable:true}
]
export default class UpdateRecordDemoFunction extends LightningElement {
    
    contacts=[]
    columns = cols
    draftValues=[]
    @wire(getListUi,{
        objectApiName:CONTACT_OBJECT,
        listViewApiName:'AllContacts'

    })
    listViewHandler({data,error}){
           if(data){
              console.log(data)
              this.contacts=data.records.records.map(item => {
                return {
                        "Id":this.getValue(item, 'Id'),
                        "Name":this.getValue(item,'Name'),
                        "Title":this.getValue(item,'Title'),
                        "Phone":this.getValue(item,'Phone'),
                        "Email":this.getValue(item,'Email')

                      }
              })
           }
           if(error){
              console.error(error)
           }
    }
    getValue(data,field){
         return data.fields[field].value
    }

    handleSave(event){
        const recordInputs=event.detail.draftValues.map(draft => {
            const fields = {...draft};
            return {fields:fields};
        })
       const promises=recordInputs.map(recordInput => updateRecord(recordInput))
       Promise.all(promises).then(()=>{
           console.log("Contact Updated SuccessFully")
           this.draftValues=[];
       }).catch(error => {
           console.log("Error Updating The Record", error)
       })
        
    }

}