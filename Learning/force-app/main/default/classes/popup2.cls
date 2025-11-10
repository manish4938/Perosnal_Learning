public class popup2 {
public boolean displayPopup {get; set;}
public boolean displayinnerPopup {get; set;}
public void closePopup() {
displayPopup = false;
displayinnerPopup=true;
}
public void showPopup() {
displayPopup = true;
displayinnerPopup =false;

}
public void showinnerpopup() {
displayinnerPopup = true;
}
public void closeinnerpopup() {
displayinnerPopup =false;
}
}