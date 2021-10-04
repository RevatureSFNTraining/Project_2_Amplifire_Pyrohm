({
	doInit : function(component, event, helper) {
        let applicationId = '1e5247ce-6add-479b-9a79-2c9d2e52df50'
        let applicationSecret = '2f042ed8fb5aab4fbd739cb64e3ea4928e3caffdd0b804af961e04625b84dc49fc61dbdf5e0e6dd2c7004db69da08049856f1845d608ef4bc64b53265c9c58fe4abc094ede2cae682944b00d3f7aa276cc13e4c474eea14fc4860659752b6d771e37dfebc6b733835ae72473b8ade7b9'
        const hash = btoa(`${applicationId}:${applicationSecret}`);
		console.log('init');
        // astro fetch
        let url = 'https://api.astronomyapi.com/api/v2/studio/moon-phase'
        let ymd = new Date();
        let data = {
                           
            "format": "png",
            "style": {
                "moonStyle": "sketch",
                //"backgroundStyle": "stars",
                "backgroundColor": "#0000",
                "headingColor": "white",
                "textColor": "#6f54fc"
            },
            "observer": {
                "latitude": 6.56774,
                "longitude": 79.88956,
                "date": `${ymd.getFullYear()}-${ymd.getMonth() + 1}-0${ymd.getDate()}`     //"2020-11-01"
            },
            "view": {
                "type": "portrait-simple",
            }
        
            }
            console.log('line 28')
            fetch(url, {
                method: 'POST',
                mode: 'cors',
                headers: {
                    "X-Requested-With": "XMLHttpRequest",
                    Authorization: `Basic ${hash}`,
                },
                body: JSON.stringify(data)
    } ).then(r => r.json()).then(d => {component.set("v.moonPicture", d.data.imageUrl), component.set("v.loading", false) });
            
        
  
        fetch('http://api.weatherapi.com/v1/astronomy.json?key=f90129e267b94b479df182646211409&q=auto:ip&dt=').then(response => response.json()).then(data => { console.log(data), component.set("v.moonPhase", data.astronomy.astro.moon_phase)}).catch(error => { throw(error) } );
 		// moon picture
 		fetch('')                                                                                                                                                              
        // weather fetch                                                                                                                                                     
        fetch('http://api.weatherapi.com/v1/current.json?key=f90129e267b94b479df182646211409&q=70122&aqi=no').then(response => response.json()).then(data => { console.log(data), component.set("v.weather", [data.current.condition.text, data.current.precip_in, data.current.humidity, data.current.cloud, data.current.uv]) }).catch(error => { throw(error) } );                                                                                                                                                                                                                                                                                                              
	}
})