import { LightningElement } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import  { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DeleteRecordDemo extends LightningElement {

    recordToDelete
    changeHandler(event){
        this.recordToDelete=event.target.value;

    }

    deleteHandler(){
        deleteRecord(this.recordToDelete).then(() =>{
            console.log("Deleted Successfully")
            this.showToast("Success !!","Deleted Successfully!!","success")
        }).catch(error =>{
             console.log(error)
             this.showToast("Error !!","Error Occured","error")
        })
    }

    showToast(title,message,variant){
        this.dispatchEvent(new ShowToastEvent({ 
            title, 
            message,
            variant })
    )}
}