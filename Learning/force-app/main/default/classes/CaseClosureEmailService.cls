public class CaseClosureEmailService {
    public static void sendClosureEmails(List<Case> closedCases) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (Case c : closedCases) {
            if (c.ContactId != null) {
                Contact contact = [SELECT Email,Name FROM Contact WHERE Id = :c.ContactId LIMIT 1];
                if (contact.Email != null) {
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new String[] {contact.Email});
                    email.setSubject('Your Case ' + c.CaseNumber + ' has been Closed');
                    String body = 'Dear ' + contact.Name + ',\n\n'
                        + 'We would like to inform you that your case has been closed.\n\n'
                        + 'Case Number: ' + c.CaseNumber + '\n'
                        + 'Case Status: ' + c.Status + '\n\n'
                        + 'Thank you for reaching out to us. If you have further questions, feel free to contact us.\n\n'
                        + 'Best regards,\nYour Company Name';
                    
                    email.setPlainTextBody(body);
                    emails.add(email);
                }
            }
        }
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}