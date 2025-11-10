import { LightningElement } from 'lwc';
import searchAccounts from '@salesforce/apex/AccountController.searchAccounts'
export default class ImperativeCallWithParam extends LightningElement {
    searchKey=''
    accounts
    timer

    searchHandler(event){
        window.clearTimeout(this.timer)
       this.searchKey=event.target.value;
       this.timer = setTimeout(()=>{
        this.callApex()
    }, 1000)
    }
    callApex(){
        searchAccounts({searchKey:this.searchKey}).then(result =>{
           this.accounts = result
        }).catch(error => {
            console.error(error);
        })
    }
}