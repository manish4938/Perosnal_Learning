public class AirtableCalloutManager {
    public static void sendRequest() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(AirtableSynSettings.getEndPointURL());
        request.setMethod('GET');
        request.setHeader('Authorization', AirtableSynSettings.getBearerToken());
        HttpResponse response = http.send(request);
        AirtableCalloutResponse.jsonParsing(response.getBody());
    } 
}