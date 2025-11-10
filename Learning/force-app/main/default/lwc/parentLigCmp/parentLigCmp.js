import { LightningElement } from 'lwc';
export default class ParentLigCmp extends LightningElement {
  childMessage = '';
  handleDataFromChild(event){
   this.childMessage = event.detail.msg;
  }
}