public class ContactCreationQueueable implements Queueable
{
    private List<Account> accListToCreateAccounts;
    public ContactCreationQueueable(List<Account> expectingAccountFromTrigger)
    {
        this.accListToCreateAccounts=expectingAccountFromTrigger;
        
    }
public void execute(QueueableContext cont)
{
    List<Contact> conListToInsert=new List<Contact>();
    for(Account acc:accListToCreateAccounts)
    {
        Contact con=new Contact();
        con.LastName=acc.Name;
        con.AccountId=acc.Id;
        con.Phone=acc.Phone;
        conListToInsert.add(con);//add each contatc list
    }
    if(conListToInsert.size()>0)
    Insert conListToInsert;
    
}
}