({
	doInit: function(component, action, potionId) {
        action.setParams({ "potionId": potionId });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.potion", response.getReturnValue());
            } else {
                console.log(state.error);
            }
        });
        $A.enqueueAction(action);
    },
})