({
    // Function that fires the event
    sendRating: function(component, event, helper) {
        let rating = component.get("v.filterRating");
        let updateEvent = component.getEvent("sendFilterRating");
        updateEvent.setParams({ "rating": rating });
        updateEvent.fire();
        component.find("picklist").set("v.value", "choose one...");
    }
})