import { LightningElement, track } from 'lwc';
export default class calci2 extends LightningElement {
     firstNumber;
     secondNumber;
    resultValue;
    handleNumberOeChange(event) {
        this.firstNumber = event.target.value;
    }
    handleNumberTwoChange(event) {
        this.secondNumber = event.target.value;
    }
    addition() {
        this.resultValue = (this.firstNumber) + (this.secondNumber);
    }
    multification() {
        this.resultValue = (this.firstNumber) * (this.firstNumber);
    }
    subtraction() {
        this.resultValue = (this.firstNumber) - (this.firstNumber);
    }
    division() {
        this.resultValue = (this.firstNumber) / (this.firstNumber);
    }
}