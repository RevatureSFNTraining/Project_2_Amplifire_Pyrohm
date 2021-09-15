public class homeController {

    //weather api key f90129e267b94b479df182646211409
		
        
        public static String getCalloutResponseContentsAstronomy() {
            
            DateTime todaysDate = System.today();
			String todaysDateStr = todaysDate.format('yyyy-MM-dd');
            String urlAstronomy = 'http://api.weatherapi.com/v1/astronomy.json?key=f90129e267b94b479df182646211409&q=auto:ip&dt='+ todaysDateStr;
            Http h = new Http();
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(urlAstronomy);
            req.setMethod('GET');
            HttpResponse res = h.send(req);
          	JSON2ApexAstronomy ast = (JSON2ApexAstronomy)JSON.deserialize(res.getBody(), JSON2ApexAstronomy.class);
			return ast.astronomy.astro.moon_phase;
        }
    
    	public static String getCalloutResponseContentsWeather() {            
     
            String urlWeather = 'http://api.weatherapi.com/v1/current.json?key=f90129e267b94b479df182646211409&q=auto:ip&aqi=no';

            Http h = new Http();
            
            HttpRequest request = new HttpRequest();
            request.setEndpoint(urlWeather);
            request.setMethod('GET');
            HttpResponse response = h.send(request);
            JSON2ApexWeather weather = (JSON2ApexWeather)JSON.deserialize(response.getBody(), JSON2ApexWeather.class);
			return string.valueof(weather.current.humidity);
        }
}