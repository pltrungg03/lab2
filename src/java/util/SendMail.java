package util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendMail {

    private final String MAIL = "bytescholar@gmail.com";
    private final String PASSWORD = "glul dyap dehk eati";

    public void sentEmail(String toEmail, String subject, String text) {

        // Config
        Properties props = new Properties();
        //Enable authentication login mail

        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", 587);
        props.put("mail.smtp.ssl.trust", "*");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        // Authenticator
        Session session = Session.getInstance(props, new Authenticator() {

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(MAIL, PASSWORD);
            }
        });

        // Mail info
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(MAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject, "UTF-8");
            message.setText(text, "UTF-8");

            Transport.send(message);

        } catch (Exception e) {
            System.out.println(e);
        }
    }
    public static void main(String[] args) {
        SendMail s = new SendMail();
        s.sentEmail("locnhhe172340@fpt.edu.vn", "123","123");
    }

}
