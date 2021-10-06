({
    // grabs all of the knowledge records from the org that are published and validated
	doInit: function(component, action) {
		action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.knowledge", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
	},
    // grabs all of the records that contain the search terms entered, or creates a new knowledge record if none exist
    searchHelper: function(component, action, Question) {
        action.setParams({
            "Question" : Question
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                console.log("SUCCESS");
                component.set("v.knowledge", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
    }
})