({  
    createOrder : function(component) {
        let totalPrice = Number(component.get("v.total"));       
        let order = JSON.parse(JSON.stringify(component.get("v.order")))
        let currPotion = JSON.parse(JSON.stringify(component.get("v.one")));
        
        order.Number_of_Potions__c = Number(order.Number_of_Potions__c);
        order.Order_Price__c = totalPrice;
        order.Potion_Type__c = currPotion.Id;
        
        // Firing the event and passing the order data
        let createEvent = component.getEvent("createOrder");
        createEvent.setParams({ "order": order });
        //Test
        component.set("v.order.Number_of_Potions__c", 0);
        component.set("v.total", 0);
        
        createEvent.fire();
    },
    
    //printing out dinamically the total price of order
    total: function(comp, ev) {
        let total = comp.get("v.total");
        let currCount = Number(JSON.parse(JSON.stringify(ev.getParams())).value);
        let price = Number(JSON.parse(JSON.stringify(comp.get("v.one"))).Total_Price__c);  
        comp.set("v.total", price * currCount);
    },
    
    cancelOrder: function(cmp) {
        cmp.set("v.one", '')
        cmp.set("v.order.Number_of_Potions__c", 0);
        cmp.set("v.total", 0);     
    }
})