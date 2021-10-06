({
    doInit: function(component, event, helper) {
        //setting some random string so when first loading page to avoid out of potions picture to render  
        component.set("v.myTest", 'test')
 
        helper.fetchingAll(component);
        helper.fetchingPicklistValues(component);     
    },
    
    //Getting info about a single potion if user clicked on Add to Cart, handling the event from singlePotion.cmp
    handleSingleRecord: function(component, event, helper) {
        helper.handlingSingleRecord(component, event);
    },
    
    // Handling Potion order calling the apex method for creating an order and displaying success modal
    handleOrder: function(component, event, helper) {
        helper.createOrder(component, event);
    },
    
    // showing cards depending on the the type filter
    selectedType: function(comp, event, helper) {
        helper.filteringCards(comp);     
    },
    
    // Closing handler for the card
    handleClose : function(component, event, helper) {
        component.set("v.potion", '');
    },
    
})