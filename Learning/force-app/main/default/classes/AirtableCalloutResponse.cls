public class AirtableCalloutResponse {
    
    public List<AirtableRecordWrapper> records;
    
    public class AirtableRecordWrapper {
        public String id;
        public Datetime createdTime;
        public Map<String, String> fields;
    }
    
    public static List<AirtableRecordWrapper> jsonParsing(String jsonData) {
        AirtableCalloutResponse wrapper = (AirtableCalloutResponse)JSON.deserialize(jsonData, AirtableCalloutResponse.class); 
        AirtablePayloadHelper.getAirTableData(wrapper.records);
        return wrapper.records;
    }
}