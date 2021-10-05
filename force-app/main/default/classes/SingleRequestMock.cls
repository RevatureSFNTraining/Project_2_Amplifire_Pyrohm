@isTest public class SingleRequestMock implements HttpCalloutMock {
    
    public String bodyAsString;

    public SingleRequestMock (String bodyAsString) {
        this.bodyAsString = bodyAsString;
    }
    public HttpResponse respond(HttpRequest req) {
        HttpResponse resp = new HttpResponse();
        resp.setBody(bodyAsString);
        return resp;
    }
}