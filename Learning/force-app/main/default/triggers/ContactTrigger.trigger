trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    // Set to hold Account Ids impacted
    Set<Id> accountIds = new Set<Id>();
    
    // Collect Account Ids based on trigger context
    if(Trigger.isInsert || Trigger.isUndelete) {
        for(Contact c : Trigger.new) {
            if(c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
    }
    
    if(Trigger.isUpdate) {
        for(Contact c : Trigger.new) {
            if(c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
        for(Contact c : Trigger.old) {
            if(c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
    }
    
    if(Trigger.isDelete) {
        for(Contact c : Trigger.old) {
            if(c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
    }
    
    if(accountIds.isEmpty()) return; // Nothing to update
    
    // Map to hold Account Id -> Number of Contacts
    Map<Id, Integer> accountContactCountMap = new Map<Id, Integer>();
    
    // Aggregate query to count contacts per Account
    for(AggregateResult ar : [
        SELECT AccountId, COUNT(Id) cnt
        FROM Contact
        WHERE AccountId IN :accountIds
        GROUP BY AccountId
    ]) {
        accountContactCountMap.put((Id)ar.get('AccountId'), (Integer)ar.get('cnt'));
    }
    
    // Prepare list of accounts to update
    List<Account> accountsToUpdate = new List<Account>();
    for(Id accId : accountIds) {
        Integer count = accountContactCountMap.containsKey(accId) ? accountContactCountMap.get(accId) : 0;
        accountsToUpdate.add(new Account(
            Id = accId,
            Number_of_Contacts__c = count
        ));
    }
    
    // Update accounts
    if(!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}