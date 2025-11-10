import { LightningElement,wire } from 'lwc';
import {getNavItems} from 'lightning/uiAppsApi' 

export default class GetNavAdapterDemo extends LightningElement {
    
    result
    @wire(getNavItems,
        {pageSize:30,
         navItemNames:['standard-Account']
        })
    getNavAdapTest({data,error}){
        if(data){
             console.log(data)
             this.result=data.navItems[0]
        }
        if(error){
           console.error(error)
        }

    }
}