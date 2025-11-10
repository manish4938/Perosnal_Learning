public class FutureMethodDemo 
{
    //Future Method :--method should be static and void, it can not be chained,user can not pass non-primitive data type
    public FutureMethodDemo()
    {
        bath();
        breakFast();
        carService();
        watchingMovie();
        
    }
    public static void bath()
    {
        system.debug('I Am Taking bath');
    }
     @Future
    public static void breakFast()
    {
        system.debug('I having Breakfast');
    }
    @Future
    public static void carService()
    {
        system.debug('I gave my car for servicing');
    }
    public static void watchingMovie()
    {
        System.debug('I am watching movie');
    }

}