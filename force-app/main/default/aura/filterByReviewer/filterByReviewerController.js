({
    // Function that fires the event
    sendReviewer: function(component, event, helper) {
        let reviewer = component.get("v.filterName");
        let updateEvent = component.getEvent("sendFilterReviewer");
        updateEvent.setParams({ "reviewer": reviewer });
        updateEvent.fire();
        component.find("picklist").set("v.value", "choose one...");
    }
})