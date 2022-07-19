trigger CaseTrigger on Case (after update) {

    if(Trigger.isUpdate) {
        CaseHelper.getEmail(Trigger.new);
        //CaseTriggerHelper.notifiyContactOfCurrentDate();
    }
    
}