({
    helperMethod : function(component, potion, button) {	        
        
        let createEvent = component.getEvent("regAdd");
        createEvent.setParams({
            "singlePotion" : potion,
            "myString" : button
        });
        createEvent.fire();
    },
})