trigger IuserTrigger on Iuser__c(after insert)
{
    if(Trigger.isInsert)
    {
        if(Trigger.isAfter)
        {
            //This Trigger is Used to Create a feedback once te user account is created..!!
           IuserHandler.createFeedback(Trigger.new);
        }
    }

}