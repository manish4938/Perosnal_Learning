public class CreateThreadFuelIx {    
    public static String sendRequest() {
        String apiKEY='u9ZNzNZYoXPAE0jI9MVqlaQMzG5CMB5vhnjiAfEizly4yL7y';
        String returnValue='Test';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.fuelix.ai/v1/threads');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', 'Bearer '+ apiKEY);
        //request.setHeader('Accept', 'text/event-stream');
        //request.setHeader('OpenAI-Beta', 'assistants=v2');
        request.setBody('');
        system.debug('Request>>>');
        try {
            
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                system.debug('Reponse>>>' + response.getBody());
                return response.getBody();
            }
            else
            {
                system.debug('Reponse>>>' + response.getStatusCode());
                system.debug('Reponse>>>' + response.getStatus());
            }
            
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
        return returnValue;
    }
}