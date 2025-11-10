import { LightningElement } from 'lwc';

export default class Child2ParentModal extends LightningElement {

    closePopup(){
        const myevent= new CustomEvent('close');
        this.dispatchEvent(myevent);
    }
}