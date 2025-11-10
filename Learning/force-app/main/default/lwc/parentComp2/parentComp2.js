import { LightningElement } from 'lwc';

export default class ParentComp2 extends LightningElement {

    handleModal(){
        const showEventModal = new CustomEvent('close',{
            detail : "Model Closed SuccessFully !!"
        });
        this.dispatchEvent(showEventModal);
    }
}