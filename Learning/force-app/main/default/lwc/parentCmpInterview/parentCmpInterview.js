import { LightningElement,track} from 'lwc';
import getAccList from '@salesforce/apex/AccountData.getAccList';
export default class ParentCmpInterview extends LightningElement {
  @track searchKey = '';
  @track accounts;
  name ='Manish Raj';
  phone='+919066581588';
  sendDataToParent
  email='manish4938@gmail.com';
   inputChangeHandler(event) {
        this.searchKey = event.target.value;
    }

  handleClick(){
    getAccList({accName : this.searchKey}).then(result=>{
        this.accounts = result;
    })
  }

@track childata ;
sendDataToParent(event){
this.childata = event.detail;
}
}