public class PotionExtension {
    
    public Id potId{get;set;}
    
    public PotionExtension(ApexPages.StandardSetController stdController){}
    
    public PageReference setId(){
        // Start with defalut id value
        String tempId = 'a015f000003jCdX';
        if(potId != null) {
            tempId = potId;
        }

        // Assign url parameters with potion id
        PageReference requestPage = Page.CartPage;
        requestPage.getParameters().put('potId', tempId);
        return requestPage;        
    }
}