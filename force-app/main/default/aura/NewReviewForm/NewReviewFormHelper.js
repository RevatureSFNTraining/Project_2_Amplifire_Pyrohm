({
    doInit: function(component) {
        component.find("reviewRecordCreator").getNewRecord(
            "Potion_Review__c",
            null,
            false,
            $A.getCallback(function() {
                let rec = component.get("v.newReview");
                let error = component.get("v.newReviewError");
                if(error || (rec === null)) {
                    console.log("Error");
                } else {
                    console.log("sick");
                }
            }));
    },
    getReviews: function(component, action) {
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
    filterPotion: function(component, action, potion) {
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
        action.setParams({ "filter" : rating });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.reviews", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
    },
    saveReview: function(component, reviews, review) {
        component.find("reviewRecordCreator").saveRecord(function(saveResult) {
            if(saveResult.state === "SUCCESS") {
                console.log("success");
                reviews.push(review);
                component.set("v.reviews", reviews);
            } else if(saveResult.state === "ERROR") {
                console.log(JSON.stringify(saveResult.error));
            }
        });
        component.set("v.newReview",{ 'sobjectType': 'Potion_Review__c',
                                     'Review_Message__c': '',
                                     'Reviewer_Name__c': '',
                                     'Review_Rating__c': 3,
                                     'Potion_Type__c': ''});
    }
})