({
    // Initialization function that grabs the apex controller method then calls the doInit helper function
	doInit : function(component, event, helper) {        
        let action = component.get("c.getPublishedKnowledge");
		helper.doInit(component, action);
	},
    // handler function for pushing the search button, grabs the searchButton method from the apex controlelr and the Question value from the View
    // then calls the helper function searchHelper
    handleSave: function(component, event, helper) {
        let action = component.get("c.searchButton");
        let Question = component.get("v.Question");
        helper.searchHelper(component, action, Question);
    }
})