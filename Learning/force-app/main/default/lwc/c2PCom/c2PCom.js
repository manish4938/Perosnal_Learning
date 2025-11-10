import { LightningElement } from 'lwc';

export default class C2PCom extends LightningElement {
    showModel=false;

    showModelHandler(){
        this.showModel=true;
    }

    closePopup(){
        this.showModel=false;
    }
}