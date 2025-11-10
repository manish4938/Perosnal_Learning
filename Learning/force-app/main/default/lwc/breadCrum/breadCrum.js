import { LightningElement,wire,track } from 'lwc';
import getApexClassNames from '@salesforce/apex/BreakCrumController.getApexClassNames';
import getFlowNames from '@salesforce/apex/BreakCrumController.getFlowNames';
import getObjectName from '@salesforce/apex/BreakCrumController.getObjectName';
import getFieldName from '@salesforce/apex/BreakCrumController.getFieldName';
export default class BreadCrum extends LightningElement {
  
    @track selectedValue = ''; // Tracks selected value from combobox
    @track apexClassOptions = []; // Holds Apex class options
    @track flowOptions = [];
    @track fieldOptions=[]; // Holds Flow options
    @track  objectOptions=[];// Holds Flow options
    
    @track selectedApexClass = ''; // Selected Apex class
    @track selectedFlow = '';
    @track selectedObject=''; // Selected Object
    @track selectedField='';

    @track isObjectSelected=true;
    @track isFieldSelectionVisible=false;
    @track isFinalSelectionVisible=false;
    @track isSelectionMade = false

    @track userInput = '';
    @track resourceData = [];

    


    get options() {
        return [
            { label: 'Apex', value: 'Apex' },
            { label: 'Flow', value: 'Flow' },
            { label: 'Objects', value: 'Object'}
        ];
    }

    // Load Apex class names from the backend
    @wire(getApexClassNames)
    wiredApexClasses({ error, data }) {
        if (data) {
            this.apexClassOptions = data.map(name => ({ label: name, value: name }));
        } else if (error) {
            console.error('Error fetching Apex classes:', error);
        }
    }

    // Load Flow names from the backend
    @wire(getFlowNames)
    wiredFlows({ error, data }) {
        if (data) {
            this.flowOptions = data.map(name => ({ label: name, value: name }));
        } else if (error) {
            console.error('Error fetching Flows:', error);
        }
    }
    @wire(getObjectName)
    wiredObjects({error,data}){
        if(data){
            this.objectOptions=data.map(name=>({label:name,value:name}));
        } else if (error) {
            console.error('Error fetching Object names:', error);
        }
    }
    @wire(getFieldName, {objectName:'$selectedObject'})
    wiredFields({data,error}){
        if(data){
            this.fieldOptions=data.map(name=>({label:name,value:name}));
        }
        else if(error){
            console.error('Error fetching Object names:', error);
        }
    }

    // Check if Apex is selected
    get isApex() {
        return this.selectedValue === 'Apex';
    }

    // Check if Flow is selected
    get isFlow() {
        return this.selectedValue === 'Flow';
    }

    // Check if Workflow is selected
    get isObject() {
        return this.selectedValue === 'Object';
    }

    // Handle the combobox change
    handleChange(event) {
        this.selectedValue = event.detail.value;
    }
    handleResourceChange(event) {
        this.selectedValue = event.target.value;
        this.updateResourceArray();  // Update the array whenever resource type changes
    }

    // Handle Apex class selection
    handleApexClassChange(event) {
        this.selectedApexClass = event.detail.value;
        console.log('Selected Apex Class: ', this.selectedApexClass);
        this.updateResourceArray();
    }

    // Handle Flow selection
    handleFlowChange(event) {
        this.selectedFlow = event.detail.value;
        console.log('Selected Flow: ', this.selectedFlow);
        this.updateResourceArray();
    }
    handleObjectChange(event){
        console.log('handleObjectChangecalled');
        this.selectedObject=event.detail.value;
        console.log('Selected Object: ', this.selectedObject);
        if(this.selectedObject){
            this.isFieldSelectionVisible=true;
        this.isFinalSelectionVisible=false;
        this.isSelectionMade=true;
    }
    
    }
    handleFieldChange(event){
        this.selectedField=event.detail.value;
        console.log('Selected Field: ', this.selectedField);
        if(this.selectedField){
        this.isFinalSelectionVisible=true;
        this.isObjectSelected=false;
        this.isFieldSelectionVisible=false;
        this.isSelectionMade=true;
        
         setTimeout(() => {
             this.resetSelection();
         }, 5000);
    } this.updateResourceArray();
    }
    get formattedSelection() {
        if (this.isSelectionMade) {
            return `${this.selectedObject} > ${this.selectedField}`;
        }else {
            
            return '';
        }
       
    }
    resetSelection() {
        // Reset all states to show the comboboxes again
        this.isObjectSelected = true; // Show object selection combobox
       // Hide field combobox
        this.isFinalSelectionVisible = false;
        this.isFieldSelectionVisible=false; // Hide final result
        // this.selectedObject = ''; // Reset selected object
        // this.selectedField = ''; // Reset selected field
        this.fieldOptions=[]// Clear field options
         this.isSelectionMade = false; // Reset selection made flag
    }
    test ;
    userData(event){
        this.test = event.target.value;
        console.log('@@ Text Area Data '+this.test);
    }
    updateTextareaValue(event) {
        this.userInput = event.target.value; // Update the textarea value on input
        // Update the result display
        console.log('userInput'+this.userInput )
        this.updateResourceArray();
    }
    updateResourceArray() {
        let resourcePart = '';
        
        // Construct the resource part based on selected resource type
        if (this.selectedValue === 'Apex') {
            resourcePart = `Apex :${this.selectedApexClass}`;
        } else if (this.selectedValue === 'Object') {
            resourcePart = `Input :${this.selectedObject}.${this.selectedField}`;
        }
        else if (this.selectedValue === 'Flow') {
            resourcePart =  `Flow :${this.selectedFlow}`;
        }

        // Add the resource part to the array (if it exists)
        if (resourcePart) {
            this.resourceData.push(resourcePart); // Add to the array instead of overwriting it
        }

        // Add the user input to the array (if user input exists)
        if (this.userInput) {
            this.resourceData.push(this.userInput); // Add user input dynamically
            console.log('InsidetextareaValue'+this.userInput)
        }

        // Ensure the combined result is updated by creating a fresh copy of the array
        
        this.resourceData = [...this.resourceData]; 
        console.log('data :'+this.resourceData) // Force reactivity (this triggers UI updates)
    }
    
    // Getter to combine all the elements in the array and join them into a string
    get combinedResourceData() {
        return this.resourceData.join(' '); // Join all resource and user input into a single string
    }
    get selectedResource(){
        //const newText = this.textareaValue;
        if(this.selectedValue==='Apex'){
            return `Apex :${this.selectedApexClass}`;
        }
        else if(this.selectedValue==='Flow'){
            return `Flow :${this.selectedFlow}`;
        }
        else if(this.selectedValue==='Object'){
            return `Input :${this.selectedObject}.${this.selectedField}`;

        }
        return ' ';
    }
    get selectedResourceWithInput() {
        return `${this.selectedResource} ${this.userInput}`;
    }
}