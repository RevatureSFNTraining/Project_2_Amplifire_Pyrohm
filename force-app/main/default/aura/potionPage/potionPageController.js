({
    doInit : function(component, event, helper) {
        let action = component.get("c.getPotion");
        action.setCallback(this, (response) => {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.potions", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
