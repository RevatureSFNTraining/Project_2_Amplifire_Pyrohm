@IsTest
public class JSON2ApexAstronomyTest {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'    \"location\": {'+
		'        \"name\": \"Vauxhall\",'+
		'        \"region\": \"\",'+
		'        \"country\": \"United Kingdom\",'+
		'        \"lat\": 51.49,'+
		'        \"lon\": -0.12,'+
		'        \"tz_id\": \"Europe/London\",'+
		'        \"localtime_epoch\": 1631647682,'+
		'        \"localtime\": \"2021-09-14 20:28\"'+
		'    },'+
		'    \"astronomy\": {'+
		'        \"astro\": {'+
		'            \"sunrise\": \"06:34 AM\",'+
		'            \"sunset\": \"07:17 PM\",'+
		'            \"moonrise\": \"04:05 PM\",'+
		'            \"moonset\": \"11:20 PM\",'+
		'            \"moon_phase\": \"First Quarter\",'+
		'            \"moon_illumination\": \"52\"'+
		'        }'+
		'    }'+
		'}';
		JSON2ApexAstronomy r = JSON2ApexAstronomy.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2ApexAstronomy objJSON2Apex = new JSON2ApexAstronomy(System.JSON.createParser(json));
		System.assert(objJSON2Apex != null);
		System.assert(objJSON2Apex.location == null);
		System.assert(objJSON2Apex.astronomy == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2ApexAstronomy.Astro objAstro = new JSON2ApexAstronomy.Astro(System.JSON.createParser(json));
		System.assert(objAstro != null);
		System.assert(objAstro.sunrise == null);
		System.assert(objAstro.sunset == null);
		System.assert(objAstro.moonrise == null);
		System.assert(objAstro.moonset == null);
		System.assert(objAstro.moon_phase == null);
		System.assert(objAstro.moon_illumination == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2ApexAstronomy.Astronomy objAstronomy = new JSON2ApexAstronomy.Astronomy(System.JSON.createParser(json));
		System.assert(objAstronomy != null);
		System.assert(objAstronomy.astro == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2ApexAstronomy.Location objLocation = new JSON2ApexAstronomy.Location(System.JSON.createParser(json));
		System.assert(objLocation != null);
		System.assert(objLocation.name == null);
		System.assert(objLocation.region == null);
		System.assert(objLocation.country == null);
		System.assert(objLocation.lat == null);
		System.assert(objLocation.lon == null);
		System.assert(objLocation.tz_id == null);
		System.assert(objLocation.localtime_epoch == null);
		System.assert(objLocation.localtime == null);
	}
}