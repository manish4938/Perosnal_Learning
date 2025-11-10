/**
* @File Name : AccountData.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : March 17, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | March 17, 2025 |   | Initial Version
**/

public class AccountData {
	@AuraEnabled(cacheable=true)
	public static List<Account> getAccList(String accName){
		List<Account> accList = [Select Id,Name,Phone,Email__c from Account where Name like :('%' + accName + '%')];
		return accList;
	}
}