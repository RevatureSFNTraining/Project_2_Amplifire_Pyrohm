({
	doInit : function(component, event, helper) {
		let action = component.get("c.getAccounts");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
	},
    
    deleteRecord : function(component, event, helper) {
		let action = component.get("c.deleteAccount");
        action.setParams({accountId:event.getSource().get("v.name")});
		action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
				component.set("v.accounts", response.getReturnValue());
            }
		});

		$A.enqueueAction(action);
	},
    
    openAccountModal: function(component, event, helper) {
      // Set isModalOpen attribute to true
      component.set("v.isAccountModalOpen", true);
   },
  
   closeAccountModal: function(component, event, helper) {
      // Set isModalOpen attribute to false  
      component.set("v.isAccountModalOpen", false);
       
   },
  
   openRecordModal: function(component, event, helper) {
      // Set isModalOpen attribute to true
      component.set("v.recordId", event.getSource().get("v.name"));
      component.set("v.isRecordModalOpen", true);
   },
  
   closeRecordModal: function(component, event, helper) {
      // Set isModalOpen attribute to false  
      component.set("v.isRecordModalOpen", false);
       let action = component.get("c.getAccounts");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
   },
})