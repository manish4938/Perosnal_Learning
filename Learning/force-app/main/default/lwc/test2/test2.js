import { LightningElement,track } from 'lwc';
export default class Test2 extends LightningElement {
  @track template = ''; // Stores the template text
    @track placeholders = []; // Stores the list of placeholders
    @track placeholderValues = {}; // Stores values for each placeholder
    @track generatedPrompt = ''; // Stores the final generated prompt

    // Handle changes in the template input
    handleTemplateChange(event) {
        this.template = event.target.value;
        this.extractPlaceholders();
        this.generatePrompt();
    }

    // Extract placeholders from the template
    extractPlaceholders() {
        const placeholderRegex = /\{(.*?)\}/g;
        const matches = [...this.template.matchAll(placeholderRegex)];
        this.placeholders = matches.map((match) => match[1]);
    }

    // Handle changes in the placeholder values
    handlePlaceholderChange(event) {
        const placeholder = event.target.dataset.placeholder;
        const value = event.target.value;
        this.placeholderValues = {
            ...this.placeholderValues,
            [placeholder]: value,
        };
        this.generatePrompt();
    }

    // Generate the final prompt by replacing placeholders with values
    generatePrompt() {
        let result = this.template;
        Object.keys(this.placeholderValues).forEach((key) => {
            const value = this.placeholderValues[key] || '';
            result = result.replaceAll(`{${key}}`, value);
        });
        this.generatedPrompt = result;
    }
}