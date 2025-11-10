import { LightningElement, track } from 'lwc'; 

export default class DatatableComponent extends LightningElement {
    @track modelTypeOptions = [
        { label: 'Standard', value: 'standard' },
        { label: 'Custom', value: 'custom' }
    ];

    @track modelOptions = [
        { label: 'OpenAI GPT 3.5 Turbo', value: 'gpt35' },
        { label: 'Other Model', value: 'other' }
    ];

    handleSave() {
        console.log('Save clicked');
    }

    handleDeactivate() {
        console.log('Deactivate clicked');
    }

    handleToggle(event) {
        console.log('Toggle changed:', event.target.checked);
    }

    handlePreview() {
        console.log('Preview clicked');
    }
}