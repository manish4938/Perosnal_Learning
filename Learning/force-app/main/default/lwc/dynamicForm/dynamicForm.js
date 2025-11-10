import { LightningElement, api, track } from 'lwc';
import getAllObjects from '@salesforce/apex/DynamicFormControllerManish.getAllObjects';
import createCustomFields from '@salesforce/apex/DynamicFormControllerManish.createCustomFields';

export default class DynamicForm extends LightningElement {
    @api objectApiName;
    @api recordId;

    @track isRecordPage = false;
    @track numFields;
    @track selectedObject;
    @track objectOptions = [];
    @track fieldInputs = [];
    @track showForm = false;

    connectedCallback() {
        this.isRecordPage = !!this.objectApiName && !!this.recordId;
        if (this.isRecordPage) {
            this.selectedObject = this.objectApiName;
        } else {
            getAllObjects().then(data => {
                this.objectOptions = data.map(obj => ({
                    label: obj,
                    value: obj
                }));
            });
        }
    }

    handleNumChange(event) {
        this.numFields = parseInt(event.target.value, 10);
    }

    handleObjectChange(event) {
        this.selectedObject = event.target.value;
    }

    handleContinue() {
        this.fieldInputs = [];
        for (let i = 0; i < this.numFields; i++) {
            this.fieldInputs.push({
                id: Date.now().toString() + i, // unique key
                fieldName: '',
                dataType: '',
                value: ''
            });
        }
        this.showForm = true;
    }

    handleFieldInputChange(event) {
        const index = parseInt(event.target.dataset.index, 10);
        const field = event.target.dataset.field;
        this.fieldInputs[index][field] = event.target.value;
    }

    handleSave() {
        const payload = JSON.stringify(this.fieldInputs.map(({ fieldName, dataType, value }) => ({
            fieldName, dataType, value
        })));

        createCustomFields({ objectName: this.selectedObject, fieldsJson: payload })
            .then(result => {
                alert(result);
                this.showForm = false;
                this.numFields = null;
                this.fieldInputs = [];
            })
            .catch(error => {
                console.error(error);
                alert('Error: ' + JSON.stringify(error));
            });
    }

    handleBack() {
        this.showForm = false;
    }

    get dataTypeOptions() {
        return [
            { label: 'Text', value: 'Text' },
            { label: 'Number', value: 'Number' },
            { label: 'Checkbox', value: 'Checkbox' },
            { label: 'Date', value: 'Date' },
            { label: 'Email', value: 'Email' },
            { label: 'Phone', value: 'Phone' }
        ];
    }
}