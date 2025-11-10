import { LightningElement, api, track } from 'lwc';

export default class CnrModal extends LightningElement {
    @api isOpen = false;
    @track selectedCnr;
    @track typeValue = '';
    @track phoneValue = '';

    cnrOptions = [
        { label: 'CNR-K = Cancel/Reject PON', value: 'CNR-K' },
        { label: 'CNR-E = Error', value: 'CNR-E' },
        { label: 'CNR-I = Info', value: 'CNR-I' }
    ];

    @api openModal() {
        this.isOpen = true;
    }

    closeModal() {
        this.isOpen = false;
    }

    handleCnrChange(event) {
        this.selectedCnr = event.detail.value;
    }

    handleTypeChange(event) {
        this.typeValue = event.detail.value;
    }

    handlePhoneChange(event) {
        this.phoneValue = event.detail.value;
    }

    handleSubmit() {
        const formData = {
            cnrType: this.selectedCnr,
            type: this.typeValue,
            phone: this.phoneValue
        };
        // Dispatch event to parent with form data
        this.dispatchEvent(new CustomEvent('submit', { detail: formData }));
        this.closeModal();
    }
}