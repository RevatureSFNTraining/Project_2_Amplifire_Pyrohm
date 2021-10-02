({
    // Intialization function for acquiring the list of potions from the Org
	doInit: function(component, event, helper) {
        // set action to be the getPotions action from the Apex controller
		let action = component.get("c.getPotions");
        // call the helper function to finish initialization
        helper.doInit(component, action);
	},
    // Function to fire the event to send the selected potion to the parent component
    sendPotion: function(component, event, helper) {
        // sets potion to the selected potion, and chooses which event to fire depending on the attribute "eventSelector" which is passed from the parent component
        let potion = component.get("v.selectedPotion");
        let updateEvent;
        if(component.get("v.eventSelector")) {
            updateEvent = component.getEvent("sendPotionSelect");
        } else {
            updateEvent = component.getEvent("sendFilterPotion");
        }
        updateEvent.setParams({ "potion" : potion });

        updateEvent.fire();
        if(!component.get("v.eventSelector")) {
            component.find("picklist").set("v.value", "choose one...");
        }
        
    }
})