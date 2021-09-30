({
	doInit: function(component, event, helper) {
		let action = component.get("c.getReviews");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.reviews", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
	},
    sendReviewer: function(component, event, helper) {
        let reviewer = component.get("v.filterName");
        let updateEvent = component.getEvent("sendFilterReviewer");
        updateEvent.setParams({ "reviewer": reviewer });
        updateEvent.fire();
        component.find("picklist").set("v.value", "choose one...");
    }
})