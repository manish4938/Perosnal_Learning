trigger AccountTriggerInterview on Account (before insert, before update,after insert,after update) {
   /* if(Trigger.isBefore){
        restrictDuplicatePhoneOrEmail(Trigger.new,Trigger.oldMap);
        updateSalesRepFieldAsOwnerId(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        createConBasedOnNumOfLocationEnteredOnAcc(Trigger.new);
    }
    public static void restrictDuplicatePhoneOrEmail(List<Account> triggerNew,Map<Id,Account> triggerOldMap){
        
        Set<String> phoneSet = new Set<String>();
        Set<String> emailSet = new Set<String>();
        for(Account accRerc : triggerNew){
            if(accRerc.Phone != null){
                phoneSet.add(accRerc.Phone);
            }
            if(accRerc.Email__c != null){
                emailSet.add(accRerc.Email__c);
            }
        }
        
        Map<String,Account> accMap = new Map<String,Account>();
        List<Account> accList = [Select Id,Phone From Account where Phone =: phoneSet];
        for(Account acc : accList){
            accMap.put(acc.Phone,acc);
        }
        
        Map<String,Account> accMap1 = new Map<String,Account>();
        List<Account> accList1 = [Select Id,Email__c From Account where Email__c =: emailSet];
        for(Account acc : accList1){
            accMap1.put(acc.Email__c,acc);
        }
        
        for(Account accRec : triggerNew){
            if((accMap.containsKey(accRec.Phone) && triggerOldMap == null) 
               ||(triggerOldMap != null && accRec.Phone != triggerOldMap.get(accRec.Id).Phone)
               || (accMap1.containsKey(accRec.Email__c) && triggerOldMap == null) 
               ||(triggerOldMap != null && accRec.Email__c != triggerOldMap.get(accRec.Id).Email__c)){
                   accRec.addError('Phone Or Email Can"t Be Duplicate');
               }
        }
    }
    public static void createConBasedOnNumOfLocationEnteredOnAcc(List<Account> triggernew){
        Map<id,decimal> mapAcc = new Map<id,decimal>();
        for(Account accRec : triggernew){
            mapAcc.put(accRec.Id,accRec.NumberofLocations__c);
        }
        List<Contact> listOfConToBeCreated = new List<Contact>();
        if(mapAcc.size()>0 && mapAcc!=null){
            for(Id accId:mapAcc.keyset()){
                for(integer i=0;i<mapAcc.get(accId);i++){
                    Contact conRec = new Contact();
                    conRec.LastName = 'Contact - '+ i ;
                    conRec.AccountId = accId;
                    listOfConToBeCreated.add(conRec);
                }
            }
        }
        if(listOfConToBeCreated.size() > 0){
            INSERT listOfConToBeCreated;
        }   
    } 
    public static void updateSalesRepFieldAsOwnerId(List<Account> triggerNew,Map<Id,Account> triggerOldMap){
	  Set<String> setUpOwnerId = new Set<String>();
		for(Account accRec : triggerNew){
		   setUpOwnerId.add(accRec.ownerId);
		}
		Map<Id,User> userMap = new Map<Id,User>([Select Name From User where Id =: setUpOwnerId]);
		for(Account acc : triggerNew){
		   if((acc != null && triggerOldMap == null) 
               || (acc.OwnerId != triggerOldMap.get(acc.OwnerId).Name && triggerOldMap != null)){
		      acc.Sales_Rep__c = userMap.get(acc.OwnerId).Name;
              System.debug('@@@ acc.Sales_Rep__c '+acc.Sales_Rep__c);
		   }
		}
		
	} */
}