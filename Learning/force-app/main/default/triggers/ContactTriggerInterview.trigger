trigger ContactTriggerInterview on Contact (before insert, before update,after insert, after update, after delete) {
    /*
    Set<String> accIdSet = new Set<String>();
    if(Trigger.isInsert || Trigger.isUpdate){
        for(Contact con : Trigger.new){
            if(con.AccountId != null){
                accIdSet.add(con.AccountId);
            }
        }
        popNumbOfConOnAccount(accIdSet);
    }
    if(Trigger.isDelete){
        for(Contact con : Trigger.old){
            if(con.AccountId != null){
                accIdSet.add(con.AccountId);
            }
        }
        popNumbOfConOnAccount(accIdSet);
    }
    
    public static void popNumbOfConOnAccount( Set<String> accIdSet){
        List<Account> accListToBeUpdated = new  List<Account>();
        AggregateResult[] groupResult= [SELECT AccountId, Count(Id) conCount
                                        FROM Contact
                                        WHERE AccountId In:accIdSet
                                        GROUP BY AccountId];
        for(AggregateResult res : groupResult){
            accListToBeUpdated.add(new Account(Id = String.valueOf(res.get('AccountId')),
                                               Number_Of_Contacts__c=Decimal.valueOf(String.valueOf(res.get('conCount')))));
        }
        if(accListToBeUpdated.size()>0){
            UPDATE accListToBeUpdated;
        }
    }*/
    
    if(Trigger.isBefore){
        restrictDuplicateConCreationBasedOnEmail(Trigger.new,Trigger.oldMap);
    }
    
    public static void restrictDuplicateConCreationBasedOnEmail(List<Contact> triggerNew,Map<Id,Contact> triggerOldMap){
        Set<String> emailSet = new Set<String>();
        for(Contact conRec : triggerNew){
            if(conRec.Email != null){
                emailSet.add(conRec.Email);
            }            
        }
        List<Contact> conList = [Select Id,Email From Contact where Email =: emailSet];
        Map<String,Contact> conMap = new Map<String,Contact>();
        for(Contact conRec : conList){
            conMap.put(conRec.Email,conRec);
        }
        
        for(Contact conRec : triggerNew){
            if((conMap.containskey(conRec.Email) && triggerOldMap == null && conRec.Email != null)
               ||(triggerOldMap != null && conRec.Email != null && conRec.Email != triggerOldMap.get(conRec.Id).Email)){
                conRec.Email.addError('Email Is Duplicate For Contact !');
            }
        }
    }
}