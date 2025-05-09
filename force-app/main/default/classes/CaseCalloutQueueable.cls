public class CaseCalloutQueueable implements Queueable, Database.AllowsCallouts {


    public void execute(QueueableContext qc) {
        Http h = new Http();
        HttpRequest  req = new HttpRequest();
        req.setEndpoint('https://icanhazdadjoke.com/');
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');
        HttpResponse res = h.send(req);
        System.debug(res.getBody());
        Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        System.debug('hii ' + resultMap);}
}