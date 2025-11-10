import LightningModal from 'lightning/modal';

export default class AccountModalNew extends LightningModal {
    connectedCallback() {
        super.connectedCallback();
        // Adjust size and centering after render
        setTimeout(() => {
            const container = this.template.host.closest('.slds-modal__container');
            const content = this.template.host.querySelector('.modal-content');
            if (container && content) {
                // Set 90% width and height with equal spacing
                container.style.width = '90vw';
                container.style.height = '90vh';
                container.style.maxWidth = 'none'; // Remove SLDS max-width constraint
                container.style.margin = '0 auto'; // Center horizontally
                container.style.position = 'fixed'; // Override default positioning
                container.style.top = '5%'; // 5% from top for equal vertical spacing
                container.style.left = '5%'; // 5% from left for equal horizontal spacing
                container.style.display = 'flex';
                container.style.flexDirection = 'column';
                container.style.alignItems = 'center';
                container.style.justifyContent = 'center';
                container.style.background = 'transparent'; // Ensure no background interference

                content.style.width = '100%';
                content.style.height = '100%';
                content.style.overflowY = 'auto';
                content.style.padding = '1rem';
                content.style.backgroundColor = '#fff'; // White background for content
                content.style.borderRadius = '8px';
                content.style.boxShadow = '0 5px 15px rgba(0, 0, 0, 0.3)';
            }
        }, 0);
    }

    handleClose() {
        this.close();
    }
}