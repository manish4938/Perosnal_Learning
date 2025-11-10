import { LightningElement } from 'lwc';
export default class DivDataTest extends LightningElement {
  editableParagraph;
  handleClick(){
    console.log('@@@@ Data '+this.editableParagraph);
  }
}