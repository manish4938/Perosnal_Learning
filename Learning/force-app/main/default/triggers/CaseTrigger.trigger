trigger CaseTrigger on Case (before insert, before update,after insert, after update) {
    
 TriggerDispatcher.run(new CaseTriggerHandler());
    
}