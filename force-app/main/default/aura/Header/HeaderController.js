({
	handleClick : function(component, event, helper) {
       
        let button = event.getSource().get("v.label");
        console.log(button);
		let evt = component.getEvent("switchHeader");
        evt.setParams({
            "page": button,
        });
		console.log(evt.getParam("page"));        
        evt.fire();
	}
})