import { LightningElement } from 'lwc';
import getAccountList from '@salesforce/apex/AccountController.getAccountList'
export default class ApexImperativeCall extends LightningElement {

    accounts
    handleAccountCalling(){
        getAccountList().then(result =>{
            console.log('Test')
            this.accounts=result
        }).catch(error =>{
            console.log(error)
        })
    }
}