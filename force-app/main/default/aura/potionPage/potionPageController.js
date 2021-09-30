({
    handleClose : function(component, event, helper) {
        // open cards back up
        component.find("card").forEach(card => $A.util.removeClass(card, "slds-hide"));
        // set value back to false after closing
        component.set("v.showCard", false);
        // reset potion attr SELECT Id, Name, Type_of_Potion__c, Base_Ingredient__r.Name
        component.set("v.potion", {'sObjectType': 'Potion__c', 'Name': '', 'Type_of_Potion__c': '', 'Base_Ingredient__r.Name': ''});
    },
    handleClick : function(component, event, helper) {
        // get component id
        let id = event.target.id;
        console.log(id)
        // action call
        let action = component.get("c.getPotionInstance")
        // set params to pass in as method params
        action.setParams({ i: id });
        // callback
        action.setCallback(this, (response) => {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.potion", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
        
        // find all card aura:id and hide them
        
        component.find("card").forEach(card => $A.util.addClass(card, "slds-hide"));
		// set the attribute for aura:if
        
        component.set("v.showCard", true);
        
    },
    
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