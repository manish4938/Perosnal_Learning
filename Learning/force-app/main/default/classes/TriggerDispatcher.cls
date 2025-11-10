public class TriggerDispatcher {
  
    public static void run(ITriggerHandler handler){
        
        if(Trigger.IsBefore){
            
            if(trigger.IsInsert){
                handler.beforeInsert(trigger.new);
            }
             if(trigger.IsUpdate){
                handler.beforeUpdate(trigger.new, trigger.oldMap);
            }
            
            if(trigger.IsDelete){
                handler.beforeDelete(trigger.old);
            }
        }
        
         
        if(Trigger.IsAfter){
            
            if(trigger.IsInsert){
                handler.afterInsert(trigger.new);
            }
             if(trigger.IsUpdate){
                handler.afterUpdate(trigger.new, trigger.oldMap);
            }
            if(trigger.IsDelete){
                handler.afterDelete(trigger.old);
            }
            
            if(trigger.IsUndelete){
                handler.afterUnDelete(trigger.new);
            }
        }
    }
}