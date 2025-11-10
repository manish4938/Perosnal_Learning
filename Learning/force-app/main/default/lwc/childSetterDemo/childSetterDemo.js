import { LightningElement, api } from 'lwc';

export default class ChildSetterDemo extends LightningElement {
    userDetails
    @api 
    get detail(){
       return this.userDetails
    }
    set detail(data){
        let newage =data.age*2;
        this.userDetails={...data, age:newage, "location":"India"};
    }


}