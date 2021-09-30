({
	doInit: function(component, event, helper) {
        let potionId = component.get("v.review.Potion_Type__c");
        let action = component.get("c.getPotion");
		helper.doInit(component, action, potionId);
	}
})