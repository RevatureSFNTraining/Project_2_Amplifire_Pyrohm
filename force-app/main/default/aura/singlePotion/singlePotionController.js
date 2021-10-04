({
    handleClick : function(component, event, helper) {
        let potion = component.get("v.potion"); 
        let button = event.getSource().get("v.name");
        helper.helperMethod(component, potion, button);
    },
    
})