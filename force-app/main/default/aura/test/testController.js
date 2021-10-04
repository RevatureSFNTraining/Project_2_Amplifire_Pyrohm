({
	handleClick : function(component, event, helper) {
		fetch('http://api.weatherapi.com/v1/astronomy.json?key=f90129e267b94b479df182646211409&q=auto:ip&dt=').then(r => r.json()).then(d => console.log(d));
	}
})