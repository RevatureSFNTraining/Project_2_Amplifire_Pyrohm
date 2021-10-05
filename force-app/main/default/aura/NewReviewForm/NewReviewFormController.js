({
    // The initialization function that is ran when the component is first loaded
	doInit: function(component, event, helper) {
        // calls the helper function for the initialization
        helper.doInit(component);
		
        // sets a variable action to be the getReviews action from the apex controller then calls the helper function to actually run the action
        let action = component.get("c.getReviews");
        helper.getReviews(component, action);
	},
    // handler function for saving a new review from the form
    handleSaveReview: function(component, event, helper) {
        // grabs the list of reviews stored on the component and the new review, then calls the helper function to save the review
        let reviews = component.get("v.reviews");
        let review = component.get("v.newReview");
        helper.saveReview(component, reviews, review);
    },
    // handler function for recieving the event to select what potion to review on the form
    handleSendPotionSelect: function(component, event, helper) {
        // grabs the parameter from the event then calls the helper function to select that potion on the form
        let updatePotionId = event.getParam("potion");
        component.set("v.newReview.Potion_Type__c", updatePotionId);
    },
    // handler functions for all 3 of the filter events, they all do pretty much the same thing
    handlesendFilterPotion: function(component, event, helper) {
        let updatePotionId = event.getParam("potion");
        let action = component.get("c.filterByPotion");
        helper.filterPotion(component, action, updatePotionId);
    },
    handleSendReviewer: function(component, event, helper) {
        let updateReviewer = event.getParam("reviewer");
        let action = component.get("c.filterByReviewer");
        helper.filterReviewer(component, action, updateReviewer);
    },
    handleSendRating: function(component, event, helper) {
        let updateRating = event.getParam("rating");
        let action = component.get("c.filterByRating");
        helper.filterRating(component, action, updateRating);
    },
    // handler function for clicking the reset filter button to call the helper function to get the full list of reviews to display
    resetFilter: function(component, event, helper) {
        console.log("hello");
        let action= component.get("c.getReviews");
        helper.getReviews(component, action);
    }
})