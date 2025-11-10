import { LightningElement, api} from 'lwc';

export default class TestSlider extends LightningElement {
    sliderValue=30;
    changeHandler(event){
       this.sliderValue=event.target.value;
    }

     @api slideHandler(){
        this.sliderValue=50;
     }
}