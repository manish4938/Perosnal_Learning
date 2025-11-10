public class Car{
    
   public Car(){
        parse();
    }
    
public class Car1 {
    public String make;
    public String year;
}

public void parse() {        
    Car1 c = (Car1)JSON.deserializeStrict(
        '{"make":"SFDC","year":"2020"}',
        Car1.class);
    System.debug('=========={1}======'+c.make);
    System.debug('=========={2}======'+c.year);
}
}