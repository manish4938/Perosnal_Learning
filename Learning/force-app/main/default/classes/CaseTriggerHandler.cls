public class CaseTriggerHandler implements ITriggerHandler {
    
    public static void beforeInsert(List<Case> triggerNew){
        setStatusAndPriority(triggerNew);
    }
    public static void afterInsert(List<Case> triggerNew){
        
    }
    public static void beforeUpdate(List<Case> triggerNew, Map<Id,SObject> tirggerOldMap){
        
    }
    public static void afterUpdate(List<Case> triggerNew, Map<Id,SObject> tirggerOldMap){
        
    }
    
    public static void beforeDelete(List<Case> triggerNew){
        
    }
    
     public static void afterDelete(List<Case> triggerNew){
        
    }
    
     public static  void afterUnDelete(List<case> triggerNew){
        
    }
    
    public static void setStatusAndPriority(List<Case> triggerNew){
        for(Case caseRecord : triggerNew ){
            if(caseRecord.Origin == 'Email'){
                caseRecord.Status='Test';
                caseRecord.Priority='Medium';
            }
        }
        
    }
   
}