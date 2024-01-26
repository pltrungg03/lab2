package util;

import com.google.gson.Gson;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

public class Helpers {

    public static int parseInt(String x, int defaultValues) {
        int n = defaultValues;
        try {
            n = Integer.parseInt(x);
        } catch (NumberFormatException e) {
            System.out.println("Parseint: ");
        }
        return n;
    }
    
    public static Date convertStringToDate(String dateStr) throws ParseException {
        java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
        return new java.sql.Date(date.getTime());
    }

    public static Date getDateNow(){
        java.util.Date dateNow = new java.util.Date();
        return new java.sql.Date(dateNow.getTime());
    }

    public static java.sql.Timestamp getTimestampNow(){
        return new java.sql.Timestamp(System.currentTimeMillis());
    }
    public static String formatDate(Date sqlDate) {
        // Convert java.sql.Date to LocalDate
        LocalDate localDate = sqlDate.toLocalDate();

        // Format LocalDate to display in 'DD-MM-YYYY'
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        return localDate.format(formatter);
    }

    public static <T> String convertListToJson(List<T> list){
        Gson gson = new Gson();
        return gson.toJson(list);
    }

    public static <T> String convertObjectToJson(T object){
        Gson gson = new Gson();
        return gson.toJson(object);
    }

    public static String timeLeft(Date expiredDate) {
        LocalDate expiryDate = expiredDate.toLocalDate();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime expiry = expiryDate.atStartOfDay();

        long minutesDifference = ChronoUnit.MINUTES.between(now, expiry);

        if (minutesDifference < 0) {
            return "Expired";
        } else if (minutesDifference < 60) {
            return minutesDifference == 1 ? "1 minute" : minutesDifference + " minutes";
        } else {
            long hoursDifference = minutesDifference / 60;
            if (hoursDifference < 24) {
                return hoursDifference == 1 ? "1 hour" : hoursDifference + " hours";
            } else {
                long daysDifference = ChronoUnit.DAYS.between(now.toLocalDate(), expiryDate);
                return daysDifference == 1 ? "1 day" : daysDifference + " days";
            }
        }
    }

}
