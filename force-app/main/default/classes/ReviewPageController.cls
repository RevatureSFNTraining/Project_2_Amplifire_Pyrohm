public class ReviewPageController {


    // create a new review object to store new details to submit a new review from the page
    public Potion_Review__c newReview
    {
        get;
        set;
    }
    
    // create a new review object list to store all review records
    public List<Potion_Review__c> reviewList
    {
        get
        {
            reviewList = [SELECT Name, Potion_Type__c, Potion_Type__r.Name, Review_Message__c, Review_Rating__c, Reviewer_Name__c FROM Potion_Review__c];
            return reviewList;
        }
        set;
    }


    // custom constructor for the controller to retrieve list of all Potion Review records
    // and setup the newReview object
    public ReviewPageController()
    {
        reviewList = [SELECT Name, Potion_Type__c, Potion_Type__r.Name, Review_Message__c, Review_Rating__c, Reviewer_Name__c FROM Potion_Review__c];
        newReview = new Potion_Review__c();
    }
    
    // method to save a new record and is called from a button press on page
    // input fields on page provide details
    public PageReference saveReview()
    {
        try
        {
            insert newReview;
            PageReference pref = new PageReference('https://krakenpotions-developer-edition.na163.force.com/ReviewsPage');
            //PageReference pref = new ApexPages.StandardController(newReview).view();
		    return pref;
        }
        catch(DmlException e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error Message.'));
            return null;
        }   
    }
}