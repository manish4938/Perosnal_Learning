import { LightningElement, api, track } from 'lwc';

export default class AccountModal extends LightningElement {
    @track isModalOpen = false;

    @api openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }
}