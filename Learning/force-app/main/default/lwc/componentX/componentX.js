import { LightningElement, wire } from 'lwc';
import SAMPLELWC from "@salesforce/messageChannel/SampleMessageChannel__c"
import { subscribe, MessageContext, APPLICATION_SCOPE, unsubscribe } from 'lightning/messageService';
export default class ComponentX extends LightningElement {

    @wire(MessageContext)
    context;
    recievedMessage
    subscription

    connectedCallback(){
        this. subscribeMessgae();
    }

    subscribeMessgae(){
       this.subscription = subscribe(this.context, SAMPLELWC, (message)=>{this.handleMessage(message)}, {scope:APPLICATION_SCOPE})
    }

    handleMessage(message){
        this.recievedMessage = message.lmsData.value ? message.lmsData.value : 'No Message Published'

    }
    
    unsubscribeMessage(){
        unsubscribe(this.subscription)
        this.subscription=null
    }
  
}