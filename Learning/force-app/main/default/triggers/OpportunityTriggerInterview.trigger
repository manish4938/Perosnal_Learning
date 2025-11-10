trigger OpportunityTriggerInterview on Opportunity (after insert, after update, after delete) {
    
    /* 
    Set<String> accountId = new Set<String>();
	
    if(Trigger.isInsert || Trigger.isUpdate){
	   for(Opportunity conrec : Trigger.new){
	     if(conrec.AccountId != null){
		  accountId.add(conrec.AccountId);
		 }
	   }
	}
	
	 if(Trigger.isDelete){
	   for(Opportunity conrec : Trigger.old){
	     if(conrec.AccountId != null){
		  accountId.add(conrec.AccountId);
		 }
	   }
	}
	
	if(!accountId.isEmpty()){
	   Map<Id,Decimal> conMap = new Map<Id,Decimal>();
	   for(AggregateResult res : [Select AccountId,Sum(Amount) conCount From Opportunity Where AccountId =: accountId Group By accountId]){
	        conMap.put((Id)res.get('AccountId'), (Decimal)res.get('conCount'));
	   }
	   List<Account> listAccountToBeUpdated = new List<Account>();
	   for(Id accId :accountId){
	      Decimal conCount = conMap.containsKey(accId) ? conMap.get(accId) : 0.0;
		  listAccountToBeUpdated.add(new Account(Id = accId, Max_Opp_Amount__c = conCount));
	   }
	   
	   if(listAccountToBeUpdated.size()>0){
	     UPDATE listAccountToBeUpdated;
	   }
	}
       */
}