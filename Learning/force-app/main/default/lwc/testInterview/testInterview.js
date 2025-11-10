import { LightningElement,api } from 'lwc';

export default class TestInterview extends LightningElement {
   @api  messageFromParent;

   sendDataToParent(){
    const dataToParent = new CustomEvent('send',{
        detail : 'Hi This Data Is From Child To Parent'
    });
    this.dispatchEvent(dataToParent);
   }
}