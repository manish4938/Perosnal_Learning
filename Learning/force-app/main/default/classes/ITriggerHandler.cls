public interface ITriggerHandler
{
    //By implementing this method trigger can handle all the Before Insert events
    void BeforeInsert(List<SObject> triggerNew);
    //By implementing this method trigger can handle all the Before Update events
    void BeforeUpdate(List<SObject> triggerNew, Map<Id, SObject> triggerOldMap);
    //By implementing this method trigger can handle all the Before Delete events
    void BeforeDelete(List<SObject> triggerOld);
    //By implementing this method trigger can handle all the After Insert events
    void AfterInsert(List<SObject> triggerNew);
    //By implementing this method trigger can handle all the After Update events
    void AfterUpdate(List<SObject> triggerNew, Map<Id, SObject> triggerOldMap);
    //By implementing this method trigger can handle all the After Delte events
    void AfterDelete(List<SObject> triggerOld);
    //By implementing this method trigger can handle all the After UnDelete events
    void AfterUndelete(List<SObject> triggerNew);
    
}