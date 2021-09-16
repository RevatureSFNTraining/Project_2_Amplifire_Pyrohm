public class CartPageExtension {
    
    public Potion__c potion {get; set;}
    public Decimal orderTotalPrice{get;set;}
    public boolean displayPopup {get;set;} 
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
    
    public Pagereference closePopup() {
        return Page.PotionsPage;
    } 

    public void showPopup() {

        try{ 
            Potion_Order__c potOrder = (Potion_Order__c)ctllr.getRecord();
            potOrder.Potion_Type__c = potion.Id;
            
            potOrder.Account_Purchasing__c = '0015f000002GbCvAAK';
            
            insert potOrder;
            displayPopup = true;
            orderTotalPrice = potion.Total_Price__c * potOrder.Number_of_Potions__c;
        } catch(DMLException de) {
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.FATAL, de.getDmlMessage(0)));
        } catch(Exception e) {
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.FATAL, e.getMessage()));   
        }

    }
    
    
}