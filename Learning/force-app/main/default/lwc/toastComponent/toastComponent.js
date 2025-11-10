import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class ToastComponent extends LightningElement {

    handlerFirstToast(){
      this.showToast("Success !!", "{0} Account Created {1}", "success");
    }
    handlerSecondToast(){
      this.showToast("Error !!", "Account Creation Failed", "error");
    }
    handlerThirdToast(){
       this.showToast("Warning !!", "Password Should Have 15 Characters Atleast", "warning");
    }
    handlerFourthToast(){
        this.showToast("Info !!", "Summer 2023 version released", "info");
    }

    showToast(title, message, variant){
      const event = new ShowToastEvent({
            title,
            message,
            variant,
            mode:"sticky",
            messageData:[
                'Salesforce',{
                    url:"http://www.salesforce.com/",
                    label:"Click Here"
                }
            ]
        }) 
        this.dispatchEvent(event)

    }

}