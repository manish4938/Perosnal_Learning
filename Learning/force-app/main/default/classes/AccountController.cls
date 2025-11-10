/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-16-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
        return [SELECT Id,Name,Phone,AnnualRevenue,Industry,Type FROM Account LIMIT 5];
    }


    @AuraEnabled(cacheable=true)        
    public static List<Account> fliterAccountFields(String industry){
        return [SELECT Id,Name,Industry FROM Account where Industry=:industry LIMIT 5];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey){
        String key= '%'+ searchKey + '%';
        return [SELECT Id,Name,AnnualRevenue,Industry,Type FROM Account 
                WHERE Name like :key LIMIT 5];
    }

    @AuraEnabled(cacheable=true)        
    public static List<Account> fliterAccountsByType(String type){
        return [SELECT Id,Name,Type FROM Account where Type=:type LIMIT 5];
    }
    
    @AuraEnabled
    public static List<Account> searchAccounts(String searchKey){
        String key = '%' +searchKey+ '%';
        return [SELECT Id,Name,Type FROM Account where Name LIKE :key LIMIT 5];
    }

 @Auraenabled(cacheable = true)
 public static List<Account> getAccountsByName(String name){
   List<Account> accDetails = [SELECT Id,Name,Phone,Email__c,BillingCity 
                               FROM Account 
                               WHERE Name like: ('%'+name+'%')];
   return accDetails;
 }
}