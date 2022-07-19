public with sharing class CaseHelper {

    public static Void getEmail(List<Case> updatedCase) {
        //Check if current date was filled in at this moment
        //Check Trigger.OldMap vs Trigger.new -> CurrentDate Field
        Set<Id> contactIds = new Set<Id>();
        
        //Would change to forCase instead of c
        for(Case c:updatedCase) {
            contactIds.add(c.ContactId);
        }


        Map<Id,Contact> contactEmail = new Map<Id,Contact>([SELECT Id, Email 
                                FROM Contact 
                                Where Id IN: contactIds]);

        //KeySet returns all the keys from a map. So this in this case it's giving you all the ids
        for(String key : contactEmail.keySet()) {
            Contact contact = contactEmail.get(key);
            sendEmail(contact.email);        
        }
    }

    public static void sendEmail(String conEmail) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage newEmail = new Messaging.SingleEmailMessage();
		String[] sendingTo = new String[]{conEmail};
        newEmail.setToAddresses(sendingTo);
		newEmail.setSubject('Case Updated.');
		newEmail.setPlainTextBody('Your current date was updated.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] {newEmail});
    }
}
