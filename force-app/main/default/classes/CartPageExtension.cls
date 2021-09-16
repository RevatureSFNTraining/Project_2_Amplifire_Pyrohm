public class CartPageExtension {
    
    public Potion__c potion {get; set;}
    public Decimal orderTotalPrice{get;set;}
    public boolean displayPopup {get;set;} 
    private final ApexPages.StandardController ctllr;

    public CartPageExtension(ApexPages.StandardController controller){
        // store controller locally for use when saving record
        ctllr = controller;

        // Get the potion id passed in via the url, query for that potion,
        // then assign to local property.
        String potionId = ApexPages.currentPage().getParameters().get('potId');
        if (potionId == null) {
            potionId = 'a015f000003jCdX';
        }
        string query = 'SELECT Id, Name, Total_Price__c ' +
        'FROM Potion__c WHERE Id = \'' + potionID + '\'';
        List<Potion__c> potions = Database.query(
            query
        );
        potion = potions[0];
    }
    
    public Pagereference closePopup() {
        // Redirect user to Potions page
        return Page.PotionsPage;
    } 

    public void showPopup() {
        try{ 
            // Get record from controller and assign the potion passed in from URL 
            // and hard code the purchasing account then insert.
            Potion_Order__c potOrder = (Potion_Order__c)ctllr.getRecord();
            potOrder.Potion_Type__c = potion.Id;
            potOrder.Account_Purchasing__c = '0015f000002GbCvAAK';
            insert potOrder;

            // If no errors then display pop up and calculate total price
            // wanted to use object field but did not work as expected
            displayPopup = true;
            orderTotalPrice = potion.Total_Price__c * potOrder.Number_of_Potions__c;
        } catch(Exception e) {
            // Automatic error handling and placement
        }
    }
}