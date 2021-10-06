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
    }
    
})