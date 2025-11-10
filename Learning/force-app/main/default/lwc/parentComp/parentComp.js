import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {

    isVisible=false;
    msg;
    handleOnClick(){
        this.isVisible=true;
    }

    handleChildEvent(event){
       this.msg= event.detail;
        this.isVisible=false;
    }

}