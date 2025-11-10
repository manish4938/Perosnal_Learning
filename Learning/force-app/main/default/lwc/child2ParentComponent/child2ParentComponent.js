import { LightningElement } from 'lwc';

export default class Child2ParentComponent extends LightningElement {
    showModal=false;
    msg;
    modalHandler(){
        this.showModal=true;
    }

    closeHandler(event){
        this.msg=event.detail;
        this.showModal=false;
    }
}