import { LightningElement,track  } from 'lwc';
export default class PrompotBuilderTemplate extends LightningElement {
  handleActivate() {
        console.log('Activate button clicked');
    }

    handleSave() {
        console.log('Save button clicked');
    }
}