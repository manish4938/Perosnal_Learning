import { LightningElement } from 'lwc';
export default class ParentInterviewCmp extends LightningElement {
  
  changeHandler(event){
     this.template.querySelector('c-child-interview-cmp').displayMessage(event.target.value);
  }
  messageFromChild;
  handleMessageFromChild(event){
   this.messageFromChild =event.detail;
  }
}