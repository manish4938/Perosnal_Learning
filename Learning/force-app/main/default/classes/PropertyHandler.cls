public class PropertyHandler {
    public static List<Map<String, Map<String, Decimal>>> getTotalDealAmountsByCityAndType() {
        Map<String, Map<String, Decimal>> cityTypeTotals = new Map<String, Map<String, Decimal>>();
        List<AggregateResult> results = [
            SELECT Property__r.City__c City, Property__r.Property_Type__c PropType, SUM(Deal_Amount__c) totalDealAmount
            FROM Deal__c
            GROUP BY Property__r.City__c, Property__r.Property_Type__c];
        
        for (AggregateResult result : results) {
            String city = (String) result.get('City');
            String propertyType = (String) result.get('PropType');
            Decimal totalAmount = (Decimal) result.get('totalDealAmount');
            if (!cityTypeTotals.containsKey(city)) {
                cityTypeTotals.put(city, new Map<String, Decimal>());
            }
            Map<String, Decimal> propertyTypeMap = cityTypeTotals.get(city);
            propertyTypeMap.put(propertyType, totalAmount);
        }
        
        List<Map<String, Map<String, Decimal>>> output = new List<Map<String, Map<String, Decimal>>>();
        for (String city : cityTypeTotals.keySet()) {
            Map<String, Map<String, Decimal>> cityMap = new Map<String, Map<String, Decimal>>();
            cityMap.put(city, cityTypeTotals.get(city));
            output.add(cityMap);
        }
        System.debug('@@@ Output Data '+output);
        return output;
    }
}