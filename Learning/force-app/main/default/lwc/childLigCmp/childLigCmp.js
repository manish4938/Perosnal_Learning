import { LightningElement } from 'lwc';
export default class ChildLigCmp extends LightningElement {
    sendDataToParent(){
         const event = new CustomEvent('message', {
            detail: { msg: 'Hello from Child!' },
            bubbles: true,
            composed: true
        });
        this.dispatchEvent(event);
    }
}