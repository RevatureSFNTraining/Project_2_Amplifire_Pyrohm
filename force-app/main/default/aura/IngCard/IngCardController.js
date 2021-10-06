({
    cardEventA1 : function(cmp, event, helper) { 
        var cmpEvent = cmp.getEvent("CardEventRegister"); 
        cmpEvent.setParams({"cardContent" : cmp.get("v.ing")});
        cmpEvent.setParams({"type" : "A1"});
        cmpEvent.fire(); 
    },
    
    cardEventA2 : function(cmp, event, helper) { 
        var cmpEvent = cmp.getEvent("CardEventRegister"); 
        cmpEvent.setParams({"cardContent" : cmp.get("v.ing")});
        cmpEvent.setParams({"type" : "A2"});
        cmpEvent.fire(); 
    },
    
    cardEventClick : function(cmp, event, helper) { 
        var cmpEvent = cmp.getEvent("CardEventRegister"); 
        cmpEvent.setParams({"cardContent" : cmp.get("v.ing")});
        cmpEvent.setParams({"type" : "E"});
        cmpEvent.fire(); 
    },
    
    findBool : function(cmp, event, helper) { 
        var boi = cmp.get("v.ing.Type_of_Ingredient__c");
        var boi2 = cmp.get("v.ing.Available_Potion__c");
        console.log(boi);
        if(boi == "Base"){
            cmp.set("v.isBase", "true");
            cmp.set("v.potType", "N/A")
        } else {
            cmp.set("v.isBase", "false");
            cmp.set("v.potType", boi2);
        }
    }
    
})