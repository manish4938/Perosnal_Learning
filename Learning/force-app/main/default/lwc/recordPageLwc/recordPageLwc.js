import { LightningElement, api } from 'lwc';

export default class RecordPageLwc extends LightningElement {
    @api recordId; // Automatically populated with the current record's ID

    connectedCallback() {
        console.log('Record ID:', this.recordId);
    }
}