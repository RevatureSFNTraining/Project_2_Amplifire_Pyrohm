({
    // Initialization function ran on load of the component. Gets the ID of the review's potion and sends that and the function from the 
    // apex controller to a helper function
	doInit: function(component, event, helper) {
        let potionId = component.get("v.review.Potion_Type__c");
        let action = component.get("c.getPotion");
		helper.doInit(component, action, potionId);
	}
})