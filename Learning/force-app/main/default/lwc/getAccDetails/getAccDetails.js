import { LightningElement,track } from 'lwc';
import getAccountsByName from '@salesforce/apex/AccountController.getAccountsByName';
export default class GetAccDetails extends LightningElement {
@track searchKey = '';
@track accounts;
messageFromParent = 'Parent Is Sending Data To Child';
handleSearch(){
getAccountsByName({name : this.searchKey})
.then((result) => {
  this.accounts = result;
})
.catch(error)
}
@track childData ;
sendDataToParent(event){
  this.childData = event.detail;
}
}