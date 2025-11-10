import { LightningElement, wire, track } from 'lwc';
import getDynamicResources from '@salesforce/apex/DynamicResourcesController.getDynamicResources';



export default class PromptBuilder extends LightningElement {
    
    @track resourceOptions = [];
    @track selectedValue;
    @track resolutionEnabled = true;    
    @track resolutionStatus = 'Enabled';    
    @track responseMessage = 'No response available yet. Preview will appear here after generation.';
    @track isActivate = true;

    connectedCallback() {
        this.loadDynamicResources();
    }

    loadDynamicResources() {
        getDynamicResources()
            .then(result => {
                        console.log('Fetched resources:', result); // Check what is returned

                this.resourceOptions = result.map(resource => ({
                    label: resource.label,
                    value: resource.value
                }));
            })
            .catch(error => {
                console.error('Error fetching resources:', error);
            });
    }

    handleObjectChange(event) {
        this.selectedValue = event.detail.value;
        console.log('Selected resource:', this.selectedValue);
    }

    
    handleResolutionToggle(event) {
        this.resolutionEnabled = event.target.checked;
        this.resolutionStatus = this.resolutionEnabled ? 'Enabled' : 'Disabled';
    }
    
    handleSearch(event) {
        const query = event.target.value;
        console.log(`Searching for: ${query}`);
    }
    

    handleSaveAs(event) {
        const selectedOption = event.target.value;
        if (selectedOption === 'newVersion') {
            console.log('Saving as a New Version...');
        } else if (selectedOption === 'newTemplate') {
            console.log('Saving as a New Template...');
        }
    }

    generatePreview() {
        console.log('Generating preview...');
        this.responseMessage = 'This is a dynamically generated response.';
    }

    handleSave() {
        console.log('Saving the template...');
    }

    get buttonLabel() {
        return this.isActivate ? 'Activate' : 'Deactivate';
    }

    handleDeactivate() {
        console.log('Activating the template...');
        this.isActivate = !this.isActivate;
    }

    handlePreview() {
    console.log('Previewing the template...');
    }

}