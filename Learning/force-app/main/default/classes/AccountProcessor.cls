public class AccountProcessor {
    @future
    public static void countContacts(Set<Id> accId){
        List<Account> accounts = [Select Id, Name,Number_Of_Contacts__c,(Select AccountId from Contacts) from Account Where Id IN :accId];
        for(Account acc : accounts){
            acc.Number_Of_Contacts__c = acc.contacts.size();
        }
        Update accounts;
    }
}