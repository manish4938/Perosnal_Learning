trigger DealTrigger on Deal__c (before insert,after insert,before update,after update,before delete,after delete) {
    
    if((Trigger.isAfter && Trigger.isInsert) || (Trigger.isAfter && Trigger.isUpdate)){
        DealTriggerHandler.updateTotalDealAmountOnProperty(Trigger.new,Trigger.old,Trigger.oldMap);
    }
    
    if(Trigger.isAfter && Trigger.isDelete){
        DealTriggerHandler.updateTotalDealAmountOnProperty(Trigger.new,Trigger.old,Trigger.oldMap);
    }

}