public class WordCounter {
    public static Map<String, Integer> countWordOccurrences(List<String> words) {
        Map<String, Integer> wordCountMap = new Map<String, Integer>();
        
        for (String word : words) {
            if (wordCountMap.containsKey(word)) {
                wordCountMap.put(word, wordCountMap.get(word) + 1);
            } else {
                wordCountMap.put(word, 1);
            }
        }
        System.debug('@@@ Data '+wordCountMap);
        return wordCountMap;
    }
}