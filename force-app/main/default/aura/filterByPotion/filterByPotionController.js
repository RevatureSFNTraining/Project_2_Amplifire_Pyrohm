({
	doInit: function(component, event, helper) {
		let action = component.get("c.getPotions");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.potions", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
	},
    sendPotion: function(component, event, helper) {
        let potion = component.get("v.filterPotion");
        let updateEvent = component.getEvent("sendFilterPotion");
        updateEvent.setParams({ "potion": potion });
        updateEvent.fire();
        component.find("picklist").set("v.value", "choose one...");
    }
})