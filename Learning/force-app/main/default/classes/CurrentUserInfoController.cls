public with sharing class CurrentUserInfoController {
    
      // Return type wrapper class
      public class UserWrapper {
        @AuraEnabled public String userId;
        @AuraEnabled public String email;
        @AuraEnabled public String firstName;
        @AuraEnabled public String lastName;
        @AuraEnabled public String profileId;
      }
    
     @AuraEnabled(cacheable=true)
     public static UserWrapper getCurrentUserInfo() {
        UserWrapper userInfo = new UserWrapper();
        /*
        // Using the UserInfo class (no SOQL)
        userInfo.userId = UserInfo.getUserId();
        userInfo.email = UserInfo.getUserEmail();
        userInfo.firstName = UserInfo.getFirstName();
        userInfo.lastName = UserInfo.getLastName();
        userInfo.profileId = UserInfo.getProfileId();*/
        
        return userInfo;
     }
    }