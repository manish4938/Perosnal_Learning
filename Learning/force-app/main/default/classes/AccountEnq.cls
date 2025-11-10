public class AccountEnq implements Queueable{
    private List<Account> accountList;
    public AccountEnq(List<Account> accListFromTrigger){
        this.accountList = accListFromTrigger;
    }
    public void execute(QueueableContext bc){
        List<Contact> conList = new  List<Contact>();
        for(Account accRec : accountList){
            Contact con = new Contact();
            con.LastName = accRec.Name;
            con.AccountId = accRec.Id;
            conList.add(con);
        }
        if(conList.size()> 0 ){
            INSERT conList;
        }
    }
}