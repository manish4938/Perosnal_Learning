import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountController.getAccountList'
export default class ApexWireDemo extends LightningElement {
       
    accountList
    @wire(getAccountList)
    accountData

    @wire(getAccountList)
    accountHandler({data,error}){
        if(data){
            this.accountList = data.map(item =>{
                               let newIndustry = item.Industry === 'Manufacturing' ? 'Manufacturing Company' :
                                item.Industry ===  ' ' ? 'Test' : '---------'
                                return {...item, newIndustry};
            })
        }
        if(error){
            console.error(error)
        }
    }
}