({
    // initialization helper function, initializes the force:recorddata new record for the form
    doInit: function(component) {
        component.find("reviewRecordCreator").getNewRecord(
            "Potion_Review__c",
            null,
            false,
            $A.getCallback(function() {
                let rec = component.get("v.newReview");
                let error = component.get("v.newReviewError");
                if(error || (rec === null)) {
                    console.log(error);
                } else {
                    console.log("sick");
                }
            }));
    },
    // initialization helper function, grabs the full list of reviews from the org using the apex controller
    getReviews: function(component, action) {
        component.set("v.filterReviewLabel", "All Reviews");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.reviews", response.getReturnValue());
                component.set("v.filterReviews", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
    },
    // helper function to save the review using the force:recorddata and resets the form to empty
    saveReview: function(component, reviews, review) {
        component.find("reviewRecordCreator").saveRecord(function(saveResult) {
            if(saveResult.state === "SUCCESS") {
                console.log("success");
                reviews.push(review);
                component.set("v.reviews", reviews);
                component.set("v.filterReviews", reviews);
            } else if(saveResult.state === "ERROR") {
                console.log(JSON.stringify(saveResult.error));
            }
        });
        component.set("v.newReview",{ 'sobjectType': 'Potion_Review__c',
                                     'Review_Message__c': '',
                                     'Reviewer_Name__c': '',
                                     'Review_Rating__c': 3,
                                     'Potion_Type__c': ''});
    },
    // 3 filter helper functions, each one calls the function from the apex controller to update the list of records displayed
    filterPotion: function(component, action, potion) {
        let otherAction = component.get("c.getPotionName");
        otherAction.setParams({ "potionId" : potion });
        otherAction.setCallback(this, function(response) {
            let otherState = response.getState()
                if(otherState === "SUCCESS") {
                    component.set("v.filterReviewLabel", response.getReturnValue() + " Reviews");
                } else {
                    console.log(otherState.error);
                }
            });
        $A.enqueueAction(otherAction);
        
        action.setParams({ "filter" : potion });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.reviews", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
    },
    filterReviewer: function(component, action, reviewer) {
        component.set("v.filterReviewLabel","Reviews By: " + reviewer);
        action.setParams({ "filter" : reviewer });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.reviews", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
    },
    filterRating: function(component, action, rating) {
        component.set("v.filterReviewLabel","Reviews With " + rating + " Stars");
        action.setParams({ "filter" : rating });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.reviews", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
    }
})