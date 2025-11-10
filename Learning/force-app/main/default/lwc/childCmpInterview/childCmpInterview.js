import { LightningElement,api} from 'lwc';
export default class ChildCmpInterview extends LightningElement {
 @api name;
 @api phone;
 @api email;


sendDataToParent(){
const dataToParent = new CustomEvent('send',{
       detail : 'Hi I am Passing The Data From Child To Parent'
       });
   this.dispatchEvent(dataToParent);
}
}