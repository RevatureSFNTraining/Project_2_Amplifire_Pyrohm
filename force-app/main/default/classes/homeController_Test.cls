@isTest public class homeController_Test {
   
    @isTest public static void singleAstronomyCallout() {
        SingleRequestMock fakeResp = new SingleRequestMock(
             
            '{"Astronomy": {"Astro": {"moon_phase": "half"}}}');
    
        Test.setMock(HttpCalloutMock.class, fakeResp);
        homeController.getCalloutResponseContentsAstronomy();
        System.assertEquals('{"Astronomy": {"Astro": {"moon_phase": "half"}}}', fakeResp.bodyAsString);
    }

    @isTest public static void singleWeatherCallout() {
        SingleRequestMock fakeResp = new SingleRequestMock(
             
            '{"current": {"condition":{"text":"Clear"}}, "precip_in":0.0, "humidity":90, "cloud":0, "uv":5.0}');
    
        Test.setMock(HttpCalloutMock.class, fakeResp);
        homeController.getCalloutResponseContentsWeather();
        System.assertEquals('{"current": {"condition":{"text":"Clear"}}, "precip_in":0.0, "humidity":90, "cloud":0, "uv":5.0}', fakeResp.bodyAsString);
    }
}