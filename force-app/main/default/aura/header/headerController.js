({
	handleClick : function(component, event, helper) {
       
        let button = event.getSource().get("v.label");
        console.log(button);
        component.set("v.title", button);
		let evt = component.getEvent("switchHeader");
        evt.setParams({
            "page": button,
        });
		console.log(evt.getParam("page"));        
        evt.fire();
	},

    logoutButton: function(component, event, helper){
        alert('Thanks For Visiting Kraken Potions!')
        let returnUrl='https://kraken-potion-developer-edition.na163.force.com/login'; 
         // paste your login page link here, where you want to come back
        window.location.href=returnUrl;       
          
     }
 
})