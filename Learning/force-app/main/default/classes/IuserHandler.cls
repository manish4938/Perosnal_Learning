public class IuserHandler
{
    public static void createFeedback(List<Iuser__c> newList)
    {
        List<FeedbackAndReview__c> feedbackToBeInserted=new List<FeedbackAndReview__c>();
        for(Iuser__c ic:newList)
        {
            FeedbackAndReview__c fdr=new FeedbackAndReview__c();
            fdr.Name__c=ic.First_Name__c;
            fdr.Email__c=ic.Email__c;
            fdr.Iuser__c=ic.Id;
            fdr.Data_Plan_Price__c='High';
            fdr.Customer_Care_Support__c='Good';
            fdr.Overall_Service__c='Good';
            fdr.Comment__c='Good Experience';
            feedbackToBeInserted.add(fdr);
            
        }
        if(!feedbackToBeInserted.isEmpty())
        {
            insert feedbackToBeInserted;
        }
        
    }

}