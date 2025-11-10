import { LightningElement } from 'lwc';

export default class ParentLL extends LightningElement {
    percentage=10;
    
    percHandler(event){
        this.percentage=event.target.value;
    }

    handleClick(){
        this.template.querySelector('c-call-child-on-action').slideHandler();
    }
}