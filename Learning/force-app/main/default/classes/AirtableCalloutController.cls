public class AirtableCalloutController  //implements Schedulable
{
    
   @InvocableMethod (label = 'Airtable Fetch' description = 'Returns All The Records Updated In Airtable')
    public static void syncData(){
        if(System.IsBatch() == false && System.isFuture() == false) {
            processAirtableData();
        }
    }
    
    /*public void execute(SchedulableContext sc){
         processAirtableData();
    }*/
    
    @future(callout=true)
    public static void processAirtableData() {
        AirtableCalloutManager.sendRequest();
    }    
}