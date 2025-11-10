import { LightningElement, wire } from 'lwc';
import getContactList  from '@salesforce/apex/ContactController.getContactList'
import getConDetailsBasedOnName  from '@salesforce/apex/ContactController.getConDetailsBasedOnName'
export default class ContactInfo extends LightningElement {

    contactList;
    @wire(getContactList)
    getConDetails({data,error}){
      if(data){
          this.contactList= data.map(item => {
                let newPhone = item.Phone === ' ' ? '9066581588' : '99999999999999999'
                return {...item, newPhone}
            })
      }
      if(error){
        console.error(error);
      }
    }


    @wire(getConDetailsBasedOnName)
    getContact({}){

    }
}