public with sharing class ChatGptController {
    
    private static final String API_KEY = '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';
    private static final String END_POINT ='https://api.openai.com/v1/chat/completions';
    static String responseText;
    
    @AuraEnabled
    public static String fetchChatGPTResponse(String prompt) {
        try {
            //Check if API Key is not empty (for safety)
            if (String.isEmpty(API_KEY)) { 
                return 'Error: API Key is missing.';
            }
            
            HttpRequest request = new HttpRequest();
            request.setEndpoint(END_POINT);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', 'Bearer ' + API_KEY);
            //request.setBody('{"model":"gpt-3.5-turbo","messages":[{"role":"user","content":"' + prompt + '"}]}');
            
            //Set The Request Body
            String promptData ='Message Chat-GPT.\nUser'+''+'\nAssistant';
            System.debug('@@ Entered Prompt '+prompt);
            
            Map<String,Object> promptBody = new Map<String,Object>();
            promptBody.put('role','user');
            promptBody.put('content',prompt);
            
            List<Object> lstPrompt = new List<Object>();
            lstPrompt.add(promptBody);
            
            Map<String,Object> requestBody = new Map<String,Object>();
            requestBody.put('messages',lstPrompt);
            requestBody.put('model','gpt-4o-mini');
            //requestBody.put('max_tokens',5);
            //requestBody.put('n',1);
            //requestBody.put('stop','new List<String>{'\n'}');
            
            request.setBody(JSON.serialize(requestBody));
            System.debug('Request Body : 1 '+request.getBody());
            
            Http http = new Http();
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == 200) {
                System.debug('Request Body : 2 '+request.getBody());
                Map<String, Object> respopnseBody = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                List<Object> choices = (List<Object>)respopnseBody.get('choices');
                if(choices.size() > 0){
                    Map<String,Object> choice = (Map<String,Object>)choices.get(0);
                    Map<String,Object> mpMessages = (Map<String, Object>)choice.get('message');
                    responseText = (String)mpMessages.get('content');
                    responseText = responseText != null ? responseText.trim() : '';
                    system.debug('@Data !! '+responseText);
                    return responseText;
                }
            }
            System.debug('@ Inside try() ');
            return 'Error: ' + response.getStatusCode() + ' ' + response.getStatus();
        } catch (Exception e) {
            System.debug('@ Inside catch() ');
            return 'Error: ' + e.getMessage();
        }
    }
}