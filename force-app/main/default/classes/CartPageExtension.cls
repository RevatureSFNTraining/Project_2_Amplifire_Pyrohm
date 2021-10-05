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
        System.debug('potionId: ' + potionId);
        String query = 'SELECT Id, Name, Total_Price__c ' +
        'FROM Potion__c';
        if (potionId != null) {
            query += ' WHERE Id = :potionId';
        }
        List<Potion__c> potions = Database.query(query);
        for(Potion__c pot : potions){
            potion = pot;
            break;
        }
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
            potOrder.Ordered_By__c = UserInfo.getUserId();
            // potOrder.Ordered_By__c = CurrentUser.Id;
            insert potOrder;

            // If no errors then display pop up and calculate total price
            // Wanted to use object field but did not work as expected
            displayPopup = true;
            orderTotalPrice = potion.Total_Price__c * potOrder.Number_of_Potions__c;
        } catch(Exception e) {
            // Automatic error handling and placement

            // Useful for when things like the new order notification process builder break
            // unexpilcably while using the experience cloud site.
            // ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, e.getMessage()));
        }
    }
}