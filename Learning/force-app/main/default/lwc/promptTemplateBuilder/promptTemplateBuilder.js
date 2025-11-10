import { LightningElement, track, wire } from 'lwc';
import getTemplates from '@salesforce/apex/PromptTemplateController.getTemplates';
import saveTemplate from '@salesforce/apex/PromptTemplateController.saveTemplate';
import renderTemplate from '@salesforce/apex/PromptTemplateController.renderTemplate';

export default class PromptTemplateBuilder extends LightningElement {
    @track templates = [];
    @track variables = '{}'; // JSON string
    @track renderedOutput = '';

    @wire(getTemplates)
    wiredTemplates({ error, data }) {
        if (data) {
            this.templates = data.map((template) => ({ ...template }));
        } else if (error) {
            console.error(error);
        }
    }

    handleNameChange(event) {
        this.updateTemplateField(event.target.dataset.id, 'Name', event.target.value);
    }

    handleContentChange(event) {
        this.updateTemplateField(event.target.dataset.id, 'Template_Content__c', event.target.value);
    }

    handleDescriptionChange(event) {
        this.updateTemplateField(event.target.dataset.id, 'Description__c', event.target.value);
    }

    updateTemplateField(id, field, value) {
        this.templates = this.templates.map((template) =>
            template.Id === id ? { ...template, [field]: value } : template
        );
    }

    saveTemplate(event) {
        const templateId = event.target.dataset.id;
        const template = this.templates.find((t) => t.Id === templateId);
        saveTemplate({ template })
            .then(() => {
                return refreshApex(this.templates);
            })
            .catch((error) => {
                console.error(error);
            });
    }

    addNewTemplate() {
        this.templates = [
            ...this.templates,
            { Id: null, Name: '', Template_Content__c: '', Description__c: '' },
        ];
    }

    handleVariablesChange(event) {
        this.variables = event.target.value;
        this.previewRenderedTemplate();
    }

    previewRenderedTemplate() {
        const currentTemplate = this.templates[0]; // Use the first template as an example
        if (currentTemplate) {
            try {
                const vars = JSON.parse(this.variables);
                renderTemplate({ templateContent: currentTemplate.Template_Content__c, variables: vars })
                    .then((result) => {
                        this.renderedOutput = result;
                    })
                    .catch((error) => {
                        console.error(error);
                    });
            } catch (err) {
                this.renderedOutput = 'Invalid JSON format';
            }
        }
    }
}