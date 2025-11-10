import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
    import CONTACT_OBJECT from '@salesforce/schema/Contact'
    import EMAIL_FIELD from '@salesforce/schema/Contact.Name'
export default class GetListUiAdapterDemo extends LightningElement {
    
    contacts=[]
    pageToken=null
    nextPageToken=null
    previousPageToken=null
    @wire(getListUi,{objectApiName:CONTACT_OBJECT,
         listViewApiName:'AllContacts', 
         pageSize:5, 
         sortBy:EMAIL_FIELD,
         pageToken:'$pageToken'
        })
    invokeListViewUiAdapter({data, error}){
        if(data){
            console.log(data)
            this.contacts=data.records.records;
            this.previousPageToken=data.records.previousPageToken
            this.nextPageToken=data.records.nextPageToken
        }
        if(error){
            console.error(error)
        }

    }
    previousPage(){
            this.pageToken=this.previousPageToken;
    }
    nextPage(){
            this.pageToken=this.nextPageToken;
    }
}