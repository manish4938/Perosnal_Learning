import { LightningElement, track } from 'lwc';

export default class Calci extends LightningElement {
    @track result = '';

    handleNumberClick(event) {
        const value = event.target.value;
        this.result += value;
    }

    handleOperationClick(event) {
        const operation = event.target.value;
        this.result += ` ${operation} `;
    }

    handleClearClick() {
        this.result = '';
    }

    handleEqualsClick() {
        try {
            this.result = eval(this.result);
        } catch (error) {
            this.result = 'Error';
        }
    }
}