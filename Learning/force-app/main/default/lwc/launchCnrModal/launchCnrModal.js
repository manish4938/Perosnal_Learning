import { LightningElement } from 'lwc';

export default class LaunchCnrModal extends LightningElement {
    handleOpen() {
        this.refs.modal.openModal();
    }

    handleSubmit(event) {
        const formData = event.detail;
        console.log('Submitted Data:', formData);
        // Add logic to save data (e.g., call Apex method)
    }
}