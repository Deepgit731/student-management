@RESTResource(urlMapping='/CreteLead/')
global class CreteLeadAPI {
    @HTTPPost
    global 	static  String createLeadRecord()
    {
        String fname , lname , comp;
        String fieldName,fieldValue;
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String jsonBody = req.requestBody.toString();
        JSONParser parser = JSON.createParser(jsonBody);
        while(parser.nextToken()!= null)
        {
            if(parser.getCurrentToken() != JSONToken.END_OBJECT)
            {
                fieldName = parser.getCurrentName();
                fieldValue = parser.getText();
                
                if(fieldName == 'FirstName')	
                {
                    fName = fieldValue;
                }
                else if(fieldName == 'LastName')	
                {
                    lName = fieldValue;
                }
                else if(fieldName == 'Company')	
                {
                    comp = fieldValue;
                }
            }
        }
        Lead l = new Lead(FirstName = fName, LastName = lName, Company = comp);
        insert l;
        return l.Id;
    }

}