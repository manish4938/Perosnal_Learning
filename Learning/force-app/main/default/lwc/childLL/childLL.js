import { LightningElement, api } from 'lwc';

export default class ChildLL extends LightningElement {
    @api title;
    @api number;
}