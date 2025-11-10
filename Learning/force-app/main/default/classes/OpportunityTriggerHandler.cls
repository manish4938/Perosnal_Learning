public class OpportunityTriggerHandler {

    public static void populateMaxAmount(Set<Id> accId){
        
        AggregateResult[] result = [Select AccountId,Max(Amount) amount From Opportunity where AccountId =:accId Group By AccountId];
        List<Account> listToAccToBeUpdated = new List<Account>();
        for(AggregateResult resRec : result){
            listToAccToBeUpdated.add(new Account(Id = String.valueOf(resRec.get('AccountId')),
                                                 Max_Opp_Amount__c = Decimal.valueOf(String.valueOf(resRec.get('amount')))));
        } 
        if(listToAccToBeUpdated.size()>0){
            UPDATE listToAccToBeUpdated;
        }
    } 
         
}