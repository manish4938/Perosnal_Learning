import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class PromptBuilderHome extends LightningElement {

  handleNavigation() {
        this[NavigationMixin.Navigate]({
            type: 'standard__component',
            attributes: {
                componentName: 'c__PromptComponent' // API name of the target component
            }
        });
    }
}