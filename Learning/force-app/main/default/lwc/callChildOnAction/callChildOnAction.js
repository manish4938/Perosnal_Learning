import { LightningElement,api } from 'lwc';

export default class CallChildOnAction extends LightningElement {
    @api percentage;
    sliderValue=30;
    changeHandler(event){
       this.sliderValue=event.target.value;
    }

     @api slideHandler(){
        this.sliderValue=50;
     }
}