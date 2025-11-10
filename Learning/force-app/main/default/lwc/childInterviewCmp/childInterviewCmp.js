import { LightningElement,api } from 'lwc';
export default class ChildInterviewCmp extends LightningElement {
msg;
@ api displayMessage(stringMessage){
   this.msg = stringMessage;
}
 sendMessageToParent(){
    const event = new CustomEvent('sendmessage',
    {detail:'Hi !! Passing The Message From Child To Parent'});
    this.dispatchEvent(event);
 }
}