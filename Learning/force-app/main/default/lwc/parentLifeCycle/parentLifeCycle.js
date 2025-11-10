import { LightningElement } from 'lwc';

export default class ParentLifeCycle extends LightningElement {

    constructor(){
        super();
        console.log("Parent Constructor Called !!");
    }

    connectedCallback(){
        console.log("Parent connected Call back !!");
    }

    renderedCallback(){
        console.log("Parent rendered call back");
    }

    name
    changeHandler(event){
      this.name=event.target.value;
    }

    errorCallback(error, stack){
        console.log(error.message);
        console.log(stack);
     }
}