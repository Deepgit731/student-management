global class EmailTask4 implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        String subject = email.subject != null ? email.subject.trim() : '';
        if (subject.startsWith('Issue -')) {
            Case newCase = new Case();
            newCase.Subject = email.subject;
            newCase.Description = email.plainTextBody;
           
            insert newCase;
        }

        result.success = true;
        return result;
    }
}