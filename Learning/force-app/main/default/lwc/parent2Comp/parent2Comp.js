import { LightningElement,api } from 'lwc';

export default class Parent2Comp extends LightningElement {

    closeHandler(){ 
        const myEvent = new CustomEvent('close')
        this.dispatchEvent(myEvent)
    }
}