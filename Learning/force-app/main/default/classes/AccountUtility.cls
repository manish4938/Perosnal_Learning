public class AccountUtility {
   
    public static void viewAnnualRevenue(){
        List<Account> accountsList = new List<Account>();
        accountsList = [Select Name,AnnualRevenue From Account];
        String acctRev;
        for(Account accRec : accountsList){
           acctRev = accRec.Name+':'+accRec.AnnualRevenue;
           System.debug('acctRev '+acctRev);
        }
    }
}