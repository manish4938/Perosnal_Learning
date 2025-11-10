import { LightningElement } from 'lwc';

export default class AccountModalLauncher extends LightningElement {
    handleOpenModal() {
        this.refs.modal.openModal();
    }
}