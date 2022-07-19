@isTest
private class TestCase {
    @isTest 
    static void createAndUpdateCase() {
        

        
        //Creating Contact
        Contact ct1 = new Contact();
        ct1.LastName = 'Test';
        ct1.Email = 'teachertalytadelima@hotmail.com';
        insert ct1;


        //Creating Case  
        Case cse = new Case(ContactId = ct1.Id,
                            Status = 'New',
                            origin = 'Web');
            
        cse.Current_Date__c = System.Today();

        Test.startTest();
            insert cse;
            update cse;
        Test.stopTest();
    
        List<Case> verifyCase = [
            SELECT Id
                 , ContactId
                 , Current_Date__c
            FROM Case
        ];

        System.assertEquals(1, verifyCase.size());
        for(Case css:verifyCase) {
            System.assertEquals(System.Today(),css.Current_Date__c,'Error!');
        }
                            
    }
    
}