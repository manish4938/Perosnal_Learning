import { LightningElement, track } from 'lwc';

export default class scenrioTwoInputWithAdditionAsOutput extends LightningElement {
    @track input1 = 0;
    @track input2 = 0;
    @track result = 0;

    handleInputChange(event) {
        const inputName = event.target.name;
        const inputValue = parseFloat(event.target.value);
        if (inputName === 'Input1') {
            this.input1 = inputValue;
        } else if (inputName === 'Input2') {
            this.input2 = inputValue;
        }
    }

    calculateSum() {
        this.result = this.input1 + this.input2;
    }
}