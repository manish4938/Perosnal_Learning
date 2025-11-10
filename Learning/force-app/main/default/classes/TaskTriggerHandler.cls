public class TaskTriggerHandler implements TriggerHandler {
    public static void beforeInsert(List<Account> triggerNew){
        
        
    }
    public static void afterInsert(List<Task> triggerNew){

    }
    public static void beforeUpdate(List<Task> triggerNew, Map<Id,SObject> tirggerOldMap){

    }
    public static void afterUpdate(List<Task> triggerNew, Map<Id,SObject> tirggerOldMap){
        
    }
    
    public static void beforeDelete(List<Task> triggerold){
        noDeleteExceptAdmin(triggerold);
    }
    
     public static void afterDelete(List<Task> triggerNew){
        
    }
    
     public static  void afterUnDelete(List<Task> triggerNew){
        
    }
    
    public static void noDeleteExceptAdmin(List<Task> triggerold){
        Id pid = Userinfo.getProfileId();
        Profile pname=[select Name from Profile where id=:pid];
        for(Task taskRecord : triggerold){
            if(pname.Name != 'System Administrator'){
                taskRecord.addError('No Delete Access!! Only Admin Can Delete The Record');
            }
        }
    }
}