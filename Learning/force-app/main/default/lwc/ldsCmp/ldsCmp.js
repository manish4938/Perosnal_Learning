import { LightningElement, wire, api,track } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
export default class lsdCmp extends LightningElement {
    @api objectApiName = 'Account';
    @track objectInfo;
    @track fieldOptions = [];
    @track selectedField;
    @track selectedFieldDetails;
    @track error;

    @wire(getObjectInfo, { objectApiName: '$objectApiName' })
    wiredObjectInfo({ error, data }) {
        if (data) {
            this.objectInfo = {label: data.label,apiName: data.apiName,custom: data.custom
            };
            this.error = undefined;
            // Populate field dropdown options
            this.fieldOptions = Object.values(data.fields).map(field => ({
                label: field.label,
                value: field.apiName
            }));
        }else if (error) {
            this.error = error.body?.message || 'Unknown error';
            this.objectInfo = undefined;
            this.fieldOptions = [];
            this.selectedField = undefined;
            this.selectedFieldDetails = undefined;
        }
    }
    // Handle object API name input change
    handleObjectNameChange(event) {
        this.objectApiName = event.target.value;
        this.selectedField = undefined; // Reset selected field
        this.selectedFieldDetails = undefined;
    }

    // Handle field selection
    handleFieldChange(event) {
        this.selectedField = event.detail.value;
        // Fetch field details from objectInfo
        if (this.objectInfo && this.selectedField) {
            const field = Object.values(this.objectInfo.fields).find(
                f => f.apiName === this.selectedField
            );
            this.selectedFieldDetails = field
                ? {
                      label: field.label,
                      apiName: field.apiName,
                      dataType: field.dataType,
                      required: field.required
                  }
                : undefined;
        }
    }
}