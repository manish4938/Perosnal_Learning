import { LightningElement } from 'lwc';

export default class Parent1Comp extends LightningElement {
    showModal=false;

    testChangeHandler(){
        showModal=true;
    }

    closeHandler(){
        showModal=false;
    }
}