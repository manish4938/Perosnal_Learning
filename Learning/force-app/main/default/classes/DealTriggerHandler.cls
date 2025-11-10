public class DealTriggerHandler {
  
    public static void updateTotalDealAmountOnProperty(List<Deal__c> triggerNew,List<Deal__c> triggerOld,Map<Id,Deal__c> triggerOldMap ){
        Set<Id> propertyIdSet = new Set<Id>();
       
        //For Insert And Update 
       for(Deal__c dealNewRec : triggerNew){
            if((dealNewRec.Property__c != null && triggerOldMap == null && triggerOld == null )|| 
                triggerOldMap != null && dealNewRec.Deal_Amount__c != triggerOldMap.get(dealNewRec.Id).Deal_Amount__c){
                propertyIdSet.add(dealNewRec.Property__c);
            }
        }
        /*
        //For Delete
        for(Deal__c dealOldRec : triggerOld){
            if(dealOldRec.Property__c != null){
                propertyIdSet.add(dealOldRec.Property__c);
            }
        }*/
        
        List<Property__c> propertyListToBeUpdates = new List<Property__c>();
        AggregateResult[] result = [Select Sum(Deal_Amount__c) dealAmount,Property__c From Deal__c 
                                    where Property__c =: propertyIdSet Group BY Property__c];
        for(AggregateResult resultRec : result){
            propertyListToBeUpdates.add(new Property__c (Id = (String)resultRec.get('Property__c'),
                                                        Total_Deal_Amount__c = (Decimal)resultRec.get('dealAmount')));
        }
        if(propertyListToBeUpdates.size() > 0){
            UPDATE  propertyListToBeUpdates; 
        }
    }

}