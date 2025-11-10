public with sharing class DynamicFormControllerManish {
    
    @AuraEnabled(cacheable=true)
    public static List<String> getAllObjects() {
        List<String> objectNames = new List<String>();
        Map<String, Schema.SObjectType> globalDesc = Schema.getGlobalDescribe();
        for (String obj : globalDesc.keySet()) {
            objectNames.add(obj);
        }
        objectNames.sort();
        return objectNames;
    }

    @AuraEnabled
    public static String createCustomFields(String objectName, String fieldsJson) {
        
        System.debug('@@ objectName --> '+objectName);
        System.debug('@@ fieldsJson --> '+fieldsJson);
        
        List<FieldData> fields = (List<FieldData>) JSON.deserialize(fieldsJson, List<FieldData>.class);
        List<String> resultMessages = new List<String>();

        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        //service.SessionHeader = new MetadataService.SessionHeader_element();
        //service.SessionHeader.sessionId = UserInfo.getSessionId();
        service.endpoint_x = 'callout:MetadataAPI';

        for (FieldData fd : fields) {
            try {
                MetadataService.CustomField customField = new MetadataService.CustomField();
                String cleanedName = fd.fieldName.replaceAll('[^a-zA-Z0-9]', '_');
                customField.fullName = objectName + '.' + cleanedName + '__c';
                customField.label = fd.fieldName;

                if (fd.dataType == 'Text') {
                    customField.type_x = 'Text';
                    customField.length = 255;
                } else if (fd.dataType == 'Number') {
                    customField.type_x = 'Number';
                    customField.precision = 18;
                    customField.scale = 0;
                } else if (fd.dataType == 'Checkbox') {
                    customField.type_x = 'Checkbox';
                    customField.defaultValue = 'false';
                } else if (fd.dataType == 'Date') {
                    customField.type_x = 'Date';
                } else if (fd.dataType == 'Email') {
                    customField.type_x = 'Email';
                    customField.length = 80;
                } else if (fd.dataType == 'Phone') {
                    customField.type_x = 'Phone';
                    customField.length = 40;
                }

                List<MetadataService.SaveResult> results =
                    service.createMetadata(new MetadataService.Metadata[] { customField });

                if (results != null && results[0].success) {
                    resultMessages.add('✅ Created: ' + customField.fullName);
                } else {
                    resultMessages.add('❌ Failed: ' + fd.fieldName + ' - ' + results[0].errors[0].message);
                }
            } catch (Exception ex) {
                resultMessages.add('❌ Exception for field ' + fd.fieldName + ': ' + ex.getMessage());
            }
        }

        return String.join(resultMessages, '\n');
    }

    public class FieldData {
        public String fieldName;
        public String dataType;
        public String value;
    }
}