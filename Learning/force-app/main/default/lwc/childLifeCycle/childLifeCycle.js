import { LightningElement } from 'lwc';

export default class ChildLifeCycle extends LightningElement {
    constructor(){
        super();
        console.log("Child Constructor Called !!");
    }

    connectedCallback(){
        console.log("Child connected Call back !!");
    }

    renderedCallback(){
        console.log("Child rendered call back");
    }
}