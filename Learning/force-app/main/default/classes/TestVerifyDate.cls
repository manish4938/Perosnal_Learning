@isTest
public class TestVerifyDate {
    static Date date1 = System.today();
    static Date date2 = System.today();
    
    static date myDate = date.newInstance(1990, 11, 21);
    static date newDate = myDate.addMonths(3);
    
    @isTest
    private static void testCheckDates1(){
        VerifyDate.CheckDates(date1,date2);
    }
    @isTest
    private static void testCheckDates2(){
        VerifyDate.CheckDates(date1,newDate);
    }
    @isTest
    private static void testDateWithin30Days(){
     VerifyDate.DateWithin30Days(date1,date2);
    }
    
    @isTest
    private static void testSetEndOfMonthDate(){
         VerifyDate.SetEndOfMonthDate(date1);
    }
}