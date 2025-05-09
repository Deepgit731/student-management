public class LeadCalloutService {
    
    @future(callout=true)
    public static void sendLeadToAPI(String name, String email) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://webhook.site/d6a70c1d-e406-474c-9c25-2f6d34389f48');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(new Map<String, String>{ 'name' => name, 'email' => email }));
        
        try {
            new Http().send(req);
        } catch (Exception e) {
            System.debug('Callout error: ' + e.getMessage());
        }
    }
    @future(callout=true)
    public static void notifyExternalSystem(List<Id> leadIds) {
        List<Lead> leads = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds];
        
        for (Lead ld : leads) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://externalapi.com/notify-lead-converted');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            
            String body = '{"LeadId":"' + ld.Id + '", "Email":"' + ld.Email + '"}';
            req.setBody(body);

            try {
                Http http = new Http();
                HttpResponse res = http.send(req);
                System.debug('Response: ' + res.getBody());
            } catch (Exception e) {
                System.debug('Callout failed: ' + e.getMessage());
            }
        }
    }
}