// submitCnrLauncher.js
import { LightningElement, api } from 'lwc';

export default class SubmitCnrLauncher extends LightningElement {
    @api recordId;
    showModal = false;

    handleClick() {
        this.showModal = true;
    }

    handleCloseModal() {
        this.showModal = false;
    }
}