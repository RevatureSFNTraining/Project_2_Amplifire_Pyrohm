@IsTest
public class JSON2ApexWeather_Test {
	
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
		'        \"localtime_epoch\": 1631654061,'+
		'        \"localtime\": \"2021-09-14 22:14\"'+
		'    },'+
		'    \"current\": {'+
		'        \"last_updated_epoch\": 1631649600,'+
		'        \"last_updated\": \"2021-09-14 21:00\",'+
		'        \"is_day\": 0,'+
		'        \"condition\": {'+
		'            \"text\": \"Partly cloudy\",'+
		'            \"icon\": \"//cdn.weatherapi.com/weather/64x64/night/116.png\"'+
		'        },'+
		'        \"precip_mm\": 0.0,'+
		'        \"precip_in\": 0.0,'+
		'        \"humidity\": 88,'+
		'        \"cloud\": 75,'+
		'        \"uv\": 4.0'+
		'    }'+
		'}';
		JSON2ApexWeather r = JSON2ApexWeather.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2ApexWeather.Condition objCondition = new JSON2ApexWeather.Condition(System.JSON.createParser(json));
		System.assert(objCondition != null);
		System.assert(objCondition.text == null);
		System.assert(objCondition.icon == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2ApexWeather objJSON2ApexWeather = new JSON2ApexWeather(System.JSON.createParser(json));
		System.assert(objJSON2ApexWeather != null);
		System.assert(objJSON2ApexWeather.location == null);
		System.assert(objJSON2ApexWeather.current == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2ApexWeather.Current objCurrent = new JSON2ApexWeather.Current(System.JSON.createParser(json));
		System.assert(objCurrent != null);
		System.assert(objCurrent.last_updated_epoch == null);
		System.assert(objCurrent.last_updated == null);
		System.assert(objCurrent.is_day == null);
		System.assert(objCurrent.condition == null);
		System.assert(objCurrent.precip_mm == null);
		System.assert(objCurrent.precip_in == null);
		System.assert(objCurrent.humidity == null);
		System.assert(objCurrent.cloud == null);
		System.assert(objCurrent.uv == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2ApexWeather.Location objLocation = new JSON2ApexWeather.Location(System.JSON.createParser(json));
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