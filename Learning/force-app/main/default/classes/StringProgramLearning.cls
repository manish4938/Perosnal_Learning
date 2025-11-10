public class StringProgramLearning {
    
    // Method To Reverse The Entered String
    public static String reverseString(String input) {
        String reverseStr = ' ';
        if (input != null) {
            for (Integer i = input.length() - 1; i >= 0; i--) {
                reverseStr += input.substring(i, i + 1);
            }
        }
        System.debug('@@ Reversed String '+reverseStr);
        return reverseStr;
    }
    
    // Method To Check Whether The Entered String Is Palidrome or not
    public static Boolean palindrome(String input) {
        String reverseStr = '';
        if (input != null) {
            for (Integer i = input.length() - 1; i >= 0; i--) {
                reverseStr += input.substring(i, i + 1);
            }
        }
        
        Boolean isPalindrome;
        if(input == reverseStr){
            isPalindrome = true;
        }else {
            isPalindrome=false;
        }
        System.debug('@@ String Is Palindrome? '+isPalindrome);
        return isPalindrome;
    }
    
    //Method To Calculate No. of Vowel and Const
    public static void vowelAndConstCount(String input){
        input = input.toLowerCase();
        Integer vowel = 0;
        Integer conso = 0;
        if(input != null){
            for(Integer i = 0; i <= input.length()-1;i++){
                String ch = input.substring(i, i + 1);
                if (ch >= 'a' && ch <= 'z') { // check only alphabet letters
                    if (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u') {
                        vowel++;
                    } else {
                        conso++;
                    }
                }
            }
            System.debug('Number Of Vowel '+vowel);
            System.debug('Number Of conso '+conso);
        }
    }
    
    // Method to remove duplicate characters from a given string
    public static String removeDuplicateChar(String input) {
        Set<String> seen = new Set<String>();
        String result = '';
        
        if (input != null) {
            input = input.toLowerCase();
            for (Integer i = 0; i < input.length(); i++) {
                String ch = input.substring(i, i + 1);
                if (!seen.contains(ch)) {
                    seen.add(ch);
                    result += ch;
                }
            }
        }
        System.debug('@@ Unique Characters in String: ' + result);
        return result;
    }
    
    //Method To Check whether the 2 entered String Is Anagram Or Not
    public static Boolean anagramOrNot(String input1,String input2){+
        
        input1 = input1.toLowerCase();
        input2 = input2.toLowerCase();
                                                                    
        List<String> lst1 = new List<String>();
        List<String> lst2 = new List<String>();
        
        if(input1 != null && input1 != null && input1.length() == input2.length()){
            for(Integer i=0 ;i<= input1.length()-1 ;i++){
                lst1.add(input1.subString(i,i+1));
                lst1.add(input2.subString(i,i+1));
            }
        }
        lst1.sort();
        lst2.sort();
        System.debug('@@ Is Entered String Anagram '+lst1.equals(lst2));                                                          
        return lst1.equals(lst2);
    }
    
    //Calultae Number Of Characters In String
    public static Integer countNumberOfCharInString(String charInput){
        Integer numberOfCharInStr =0;
        for(Integer i = 0; i <= charInput.length()-1 ;i++){
            numberOfCharInStr ++;
        }
        System.debug('@@ Number Of Character Are '+numberOfCharInStr);
        return numberOfCharInStr;
    }

}