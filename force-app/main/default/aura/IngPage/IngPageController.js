({
	  findIngredient : function(component, event, helper) {
       
        var action = component.get('c.grabIng');

        action.setParams({
            search : component.get("v.search"),
            filter : component.find("Select").get("v.value")+""
        });
       
        action.setCallback(this, function(response){
            var state = response.getState();
            var varResponse = response.getReturnValue();
            if(state === "SUCCESS")
            {
                component.set("v.ingredientList", varResponse);
            }
           
        });
        $A.enqueueAction(action);
 },
    handleCardEvent : function(cmp, event){
        var ing = event.getParam("cardContent");
        if(event.getParam("type") == "A1"){
            cmp.set("v.a1", ing);
        }else if (event.getParam("type") == "A2") {
            cmp.set("v.a2", ing);
        } else if (event.getParam("type") == "E") {
            cmp.set("v.ingSet", ing);
            //cmp.set("v.a2", ing);
            cmp.set("v.ifIngPage", "false");
        }
    },
    
    handleIngEvent : function(cmp, event){
        
        //if(event.getParam("type") == "P"){
        console.log("goog");
            cmp.set("v.ifIngPage", "true");
        //}
    },
    
    createPotion : function(component, event) {
        
        var potName = component.get("v.potionName");
        var potType = component.find("TypeSelect").get("v.value")+"";
        var base = component.get("v.a1.Id");
        var second = component.get("v.a2.Id");
        
        if(potName != "" && base != "" && potType != ""){
            
            var action = component.get("c.savePotion");
            
            action.setParams({ 
                "i1": base,
                "i2": second,
                "potName": potName,
                "potType": potType
            });   
            
            action.setCallback(this, function(response) { 
                var state = response.getState();       
                if (state === "SUCCESS") {  	          
                    alert("Worked");                     
                }
            });
            
            $A.enqueueAction(action) 
        } else {
            alert("Fail");
        }
    },
    
    clearA1 : function(cmp, event) {
    	cmp.set("v.a1", "");
    },
    
    clearA2 : function(cmp, event) {
    	cmp.set("v.a2", "");
    }
    
    
})