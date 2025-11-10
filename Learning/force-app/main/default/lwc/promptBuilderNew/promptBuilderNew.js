import { LightningElement, wire, track, api } from 'lwc';
import getDynamicResources from '@salesforce/apex/DynamicResourcesController.getDynamicResources';
import fetchChatGPTResponse from '@salesforce/apex/ChatGptController.fetchChatGPTResponse';

export default class PromptBuilderNew extends LightningElement {
   
    @track resourceOptions = [];
    @track selectedValue;
    @track resolutionEnabled = true;    
    @track resolutionStatus = 'Enabled';    
    @track responseMessage = 'No response available yet. Preview will appear here after generation.';
    @track isActivate = true;
    @api formData;
    @api newData;

       @track selectedCategory;
    @track categoryOptions = [
        { label: 'Apex', value: 'Apex' },
        { label: 'Flows', value: 'Flows' },
        { label: 'Metadata', value: 'Metadata' },
        { label: 'Objects', value: 'Object' } // Added "Objects" option
    ];
    @track isResourceDropdownDisabled = true;

    // Store the resources for each category
    @track apexResources = [];
    @track flowResources = [];
    @track metadataResources = [];
    @track objectResources = [];
    @track fieldResources = [];

    connectedCallback() {
        this.loadDynamicResources();
        console.log('inside child formdata', JSON.stringify(this.formData), this.newData);
        
    }

    loadDynamicResources() {
        getDynamicResources()
            .then(result => {
                console.log('Fetched resources:', result); // Check what is returned

                // Filter resources by category
                this.apexResources = result.filter(resource => resource.category === 'Apex');
                this.flowResources = result.filter(resource => resource.category === 'Flow');
                this.metadataResources = result.filter(resource => resource.category === 'Metadata');
                this.objectResources = result.filter(resource => resource.category === 'Object');
                this.fieldResources = result.filter(resource => resource.category === 'Field');

                // You can add additional processing here if needed
            })
            .catch(error => {
                console.error('Error fetching resources:', error);
            });
    }

    handleCategoryChange(event) {
        this.selectedCategory = event.detail.value;
        console.log('Selected Category:', this.selectedCategory);

        // Enable the resource dropdown once a category is selected
        this.isResourceDropdownDisabled = false;

        // Update the resource options based on the selected category
        if (this.selectedCategory === 'Apex') {
            this.resourceOptions = this.apexResources;
        } else if (this.selectedCategory === 'Flows') {
            this.resourceOptions = this.flowResources;
        } else if (this.selectedCategory === 'Metadata') {
            this.resourceOptions = this.metadataResources;
        } else if (this.selectedCategory === 'Object') {
            this.resourceOptions = this.objectResources;
        } else if (this.selectedCategory === 'Field') {
            this.resourceOptions = this.fieldResources;
        }
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
    
    // Gpt Code
    @track userInput = '';
    @track response = '';

    handleInputChange(event) {
        this.userInput = event.target.value;
    }

    getChatGptResponse() {
        if (this.userInput) {
            fetchChatGPTResponse({ prompt: this.userInput })
                .then(result => {
                    this.response = result;
                })
                .catch(error => {
                    this.response = 'Error: ' + error.body.message;
                });
        } else {
            this.response = 'Please enter a message.';
        }
    }
}