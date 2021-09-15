public class CartPageExtension {
    
    public Potion__c potion {get; set;}
    private final ApexPages.StandardController ctllr;

    public CartPageExtension(ApexPages.StandardController controller){
        string potionId = ApexPages.currentPage().getParameters().get('potId');
        if (potionId == null) {
            potionId = 'a015f000003jCdX';
        }
        ctllr = controller;
        string query = 'SELECT Id, Name, Total_Price__c ' +
        'FROM Potion__c WHERE Id = \'' + potionID + '\'';
        List<Potion__c> potions = Database.query(
            query
        );
        potion = potions[0];
    }
    
    
    public PageReference save(){
        // account id = 0015f000002GbCvAAK;
        return Page.PotionsPage;
    }

    
    public boolean displayPopup {get;set;} 
    public Pagereference closePopup() 
    {
        return Page.PotionsPage;
    } 
    public void showPopup() 
    {
        displayPopup = true; 
    }
    
    
}