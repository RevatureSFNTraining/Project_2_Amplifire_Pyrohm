({
	back : function(cmp, event, helper) { 
        var cmpEvent = cmp.getEvent("IngEvent"); 
        cmpEvent.setParams({"ret" : "P"});
        cmpEvent.fire(); 
    },

	doInit : function(component, event, helper) {
		console.log('running');
		let action = component.get("c.getRelatedPotions");
		action.setParams({inName:component.get("v.ing.Id")});
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
				console.log(response.getReturnValue());
                component.set("v.relatedPotions", response.getReturnValue());
            }
			else {
				console.error(state);
			}
        });
        
        $A.enqueueAction(action);
	}
})