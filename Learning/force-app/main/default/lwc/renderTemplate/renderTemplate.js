import { LightningElement } from 'lwc';
import signinTemplate from './signin.html'
import signupTemplate from './signup.html'
import renderTemplate from './renderTemplate.html'

export default class RenderTemplate extends LightningElement {
    selectedBtn='';
    render(){
        return this.selectedBtn === 'Signup' ? signupTemplate:
               this.selectedBtn ===  'Signin' ? signinTemplate:
               renderTemplate;

    }

    handleClick(event){
     this.selectedBtn = event.target.label;
    }

}