import { LightningElement } from 'lwc';
export default class HelloWorld extends LightningElement {
 // Properties for picklist, textarea, and concatenated value
    options = [
        { label: 'Option 1', value: 'Option 1' },
        { label: 'Option 2', value: 'Option 2' },
        { label: 'Option 3', value: 'Option 3' }
    ];
    selectedOption = '';
    userInput = '';
    concatenatedValue = '';

    // Handler for picklist changes
    handlePicklistChange(event) {
        this.selectedOption = event.target.value;
        this.updateConcatenatedValue();
    }

    // Handler for textarea input changes
    handleTextareaChange(event) {
        this.userInput = event.target.value;
        this.updateConcatenatedValue();
    }

    // Update the concatenated value
    updateConcatenatedValue() {
        this.concatenatedValue = `${this.userInput} ${this.selectedOption}`.trim();
    }
}