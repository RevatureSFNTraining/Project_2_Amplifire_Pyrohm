({
	doInit : function(component, event, helper) {
        component.find("FAQCreator").getNewRecord(
            "Potion_Review__c",
            null,
            false,
            $A.getCallback(function() {
                let rec = component.get("v.newQuestion");
                let error = component.get("v.newError");
                if(error || (rec === null)) {
                    console.log(error);
                } else {
                    console.log("sick");
                }
            }));
        
        let action = component.get("c.getPublishedKnowledge");
		action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.knowledge", response.getReturnValue());
            } else {
                console.log(state);
            }
        });
        $A.enqueueAction(action);
	},
    handleSave: function(component, event, helper) {
        let question = component.get("v.newQuestion");
        let title = component.get("v.newQuestion.Title");
        component.set("v.newQuestion.UrlName", title);
        component.find("FAQCreator").saveRecord(function(saveResult) {
            if(saveResult.state === "SUCCESS") {
                console.log("success");
            } else if(saveResult.state === "ERROR") {
                console.log(JSON.stringify(saveResult.error));
            }
        });
        component.set("v.newReview",{ 'sobjectType': 'Knowledge__kav',
                                     'Title': '',
                                     'UrlName': '',
                                     'Question__c': '' });
    }
})