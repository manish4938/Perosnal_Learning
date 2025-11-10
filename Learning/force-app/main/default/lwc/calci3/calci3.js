import { LightningElement } from 'lwc';

export default class Calci3 extends LightningElement {
    number1
    number2
    result

    number1Handler(event){
        this.number1 =parseInt(event.target.value);
    }
    number2Handler(event){
        this.number2 =parseInt(event.target.value);
    }

    addOfNumber(){
         this.result= parseInt(this.number1) + parseInt(this.number2);
    }
    subOfNumber(){
        this.result= (this.number1) - this.number2;
    }
    mulOfNumber(){
        this.result= (this.number1) * this.number2;
    }
    divOfNumber(){
        this.result= (this.number1) / this.number2;
    }
    clearInput(){
        this.number1=''
        this.number2=''
        this.result=''
    }
}