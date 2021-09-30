({
	doInit: function(component, event, helper) {
        helper.doInit(component);
		
        let action = component.get("c.getReviews");
        helper.getReviews(component, action);
	},
    handleSaveReview: function(component, event, helper) {
        let reviews = component.get("v.reviews");
        let review = component.get("v.newReview");
        helper.saveReview(component, reviews, review);
    },
    handleSendPotionSelect: function(component, event, helper) {
        let updatePotionId = event.getParam("potion");
        component.set("v.newReview.Potion_Type__c", updatePotionId);
    },
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
    }
})