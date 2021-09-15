public class PotionExtension {
    //private final Potion__c pot;
    
    public Id addedPot{
        get;
        set;
    }
    
    public PotionExtension(ApexPages.StandardSetController stdController){
        //pot = (Potion__C)stdController.getRecord();
    }
    
    public PageReference setId(){
        String tempId = 'a015f000003jCdX';
        if(addedPot != null) {
            tempId = addedPot;
        }
        PageReference requestPage = Page.CartPage;
        requestPage.getParameters().put('potId', tempId);
        //requestPage.getParameters().put('Id', 'a015f000003jCdX');
        requestPage.setRedirect(true);
        return requestPage;        
    }

    public boolean displayPopup {get;set;} 
    public void closePopup() 
    {
        displayPopup = false; 
    } 
    public void showPopup() 
    {
        displayPopup = true; 
    }

}