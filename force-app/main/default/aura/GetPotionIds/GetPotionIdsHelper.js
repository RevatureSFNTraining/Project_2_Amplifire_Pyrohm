({
    // initialization helper function, initializes the force:recorddata new record for the form
    doInit: function(component, action) {
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
})