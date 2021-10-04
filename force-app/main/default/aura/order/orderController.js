({
    //going back to all potions component
    cancelOrder: function(cmp,event, helper) {
        helper.cancelOrder(cmp);
    },
    //handling order and firing the event
    handleOrder : function(component, event, helper) {   
        helper.createOrder(component);       
    },
    //showing total price dinamically      
    handlingTotal: function(comp, ev, helper) {
        helper.total(comp, ev);  
    }
})