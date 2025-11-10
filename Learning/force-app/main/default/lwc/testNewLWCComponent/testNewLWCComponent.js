import { LightningElement,track} from 'lwc';

export default class TestNewLWCComponent extends LightningElement {
    fullname='Zero To Hero';
    title='LWC';

    changeHandler(event){
        this.title = event.target.value;
    }

    /*@track address={
        area:'BTM STAGE-2',
        city:'Bangalore',
        Country:'India',
        PostalCode:'560076'
    }*/

    address={
        area:'BTM STAGE-2',
        city:'Bangalore',
        Country:'India',
        PostalCode:'560076'
    }

    changetrackHandler(event){
        //this.address.city = event.target.value;
        this.address={...this.address,'city':event.target.value};
    }
}