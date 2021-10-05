({
    //Fetching all records
    fetchingAll : function(component) {
        var action = component.get("c.fetchPotionList");
        
        action.setCallback(this, function(response){
            let state = response.getState();
            if(state === "SUCCESS") {
                console.log('Returning all the potions >>>>   ', response.getReturnValue());
                component.set("v.potions", response.getReturnValue());
                component.set("v.potions2", response.getReturnValue());
                //getting all and store so i can get them later when filtering 
                //TEST
                //
                 component.set("v.myTest", "");
                
                component.set("v.myTest", 'kor')
                console.log('after   ', component.get("v.myTest"));
                
                
            } else {
                console.log('Something went wrong: ' + state);
            }          
        });
        $A.enqueueAction(action);
    },
    
    //Getting all the PickListValues from the Potion types
    fetchingPicklistValues : function(component){
        var action2 = component.get("c.getOptions");
        
        action2.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS"){
                let options = a.getReturnValue();
                options.unshift('See All');
                options.unshift('-- Filter by Type of Potion --');    
                component.set("v.options", options);
            } 
        });
        $A.enqueueAction(action2);
    },
    
    //Filtering cards depending on the potion type
    filteringCards : function(comp) {
        //getting all from the init function
        let allPotions = comp.get("v.potions2");
        
        //selected Value 
        let one = comp.find("selectOne").get("v.value");
        
        //filtering depending on the filter word
        let all = JSON.parse(JSON.stringify(allPotions));
        all = all.filter(p => p.Type_of_Potion__c == one);
        
        if (one == 'See All') {
            comp.set("v.potions", allPotions);
        } else {
            comp.set("v.potions", all);
        } 
    },
    
    handlingSingleRecord: function(component, event) {
        let currentPotion = event.getParam("singlePotion");
        let myString = event.getParam("myString");
        
        if (myString == 'cart') {
            component.set("v.single", currentPotion);
        }
        if(myString == 'detail') {
            component.set("v.potion", currentPotion);
        }
    },
    
    // Create an order and calling APEX method
    createOrder : function(component, event) {
        
        //saving Potion order to the server
        let newOrder = event.getParam("order");
        let action = component.get("c.saveOrder");
        action.setParams({  "order": newOrder });
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log('SUCCESS, order has been made');
                
                setTimeout(function(){ component.set("v.single", ''); }, 200); 
                component.set("v.ifSuccess", true);
                setTimeout(function(){ component.set("v.ifSuccess", false)}, 2200);
            } else {
                console.error('There\'s been some error with the callback');
            }
        })
        $A.enqueueAction(action);
        
    },
})