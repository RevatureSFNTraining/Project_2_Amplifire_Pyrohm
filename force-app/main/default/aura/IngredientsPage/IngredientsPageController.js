({
	back : function(cmp, event, helper) { 
        var cmpEvent = cmp.getEvent("IngEvent"); 
        cmpEvent.setParams({"ret" : "P"});
        cmpEvent.fire(); 
    },

	doInit : function(component, event, helper) {
		let action = component.get("c.getRelatedPotions");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.relatedPotions", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
	}
})