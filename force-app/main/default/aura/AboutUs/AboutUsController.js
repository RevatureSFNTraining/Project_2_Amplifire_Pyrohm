({
	findReviews : function(component, event, helper) {
       
        var action = component.get('c.fetchReviews');

        action.setParams({
            //searchKeyWord : component.get("v.keywordHolder"),
            //filter : component.find("Select").get("v.value")+""
        });
       
        action.setCallback(this, function(response){
            var state = response.getState();
            var response = response.getReturnValue();
            if(state === "SUCCESS")
            {
                component.set("v.reviewList", response);
            }
           
        });
        
        $A.enqueueAction(action);
 },
})