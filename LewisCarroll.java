		import java.io.BufferedReader;
		import java.io.FileReader;
		import java.io.IOException;
		import java.util.ArrayList;
		import java.util.Arrays;
		import java.util.Scanner;

		public class LewisCarroll {
			
			public static void main(String[] args) throws IOException {
				ArrayList<String> wordList = new ArrayList<String>();
				boolean wordChain = true;
				wordList = readDictionary();
				Scanner input = new Scanner(System.in);
				boolean finish = false;
				while(!finish) {
				ArrayList<String> inputWords = new ArrayList<String>();
				String word = "";
				System.out.println("Enter a comma separated list of words (or an empty list to quit):");
				if(input.hasNextLine()) {
					word+=input.nextLine();
				inputWords = readWordList(inputWords, word);
				if(word.equalsIgnoreCase("")) {
					System.out.println("You have quit.");
					break;
				}
				wordChain = isWordChain(inputWords, wordList);
				if(wordChain == true) {
					System.out.println("Valid chain of words from Lewis Carroll's word-links game.");
					inputWords.clear();
				}
				if(wordChain == false){
					System.out.println("Not a valid chain of words from Lewis Carroll's word-links game.");
					inputWords.clear();
						}
					}
				else {
					finish = true;
						}
					}
				}
			public static boolean isWordChain(ArrayList<String> inputWords, ArrayList<String> wordList) throws IOException {
			boolean wordChain = true;
				boolean unique = isUniqueList(inputWords);
				boolean isEnglish = isEnglishWord(inputWords, wordList);
				boolean sameLength = isDifferentByOne(inputWords);
				if(unique == false || isEnglish == false || sameLength == false) {
					wordChain = false;
					}
			
					return wordChain;
				}
			public static ArrayList<String> readDictionary() throws IOException {
				FileReader file = new FileReader("words.txt");
				BufferedReader dictionary = new BufferedReader(file);
				String word ="";
				ArrayList<String> wordList = new ArrayList<String>(Arrays.asList(word.split("\n")));
				while((word = dictionary.readLine()) != null) {		
					wordList.add(word);
				}
				return wordList;
			}
			public static ArrayList<String> readWordList(ArrayList<String>inputWords, String word){
				ArrayList<String> wordList = new ArrayList<String>(Arrays.asList(word.split(",")));
				return wordList;
			}
			public static boolean isUniqueList(ArrayList<String> inputWords) {
				boolean unique = true;
				ArrayList<String> inputWords2 = new ArrayList<String>();
				for(int a = 0; a < inputWords.size(); a++) {
					inputWords2.add(inputWords.get(a));
					}
				for(int i = 0; i<inputWords2.size(); i++) {
					String compare1 = inputWords2.get(i);
					for(int g = 1; g< inputWords2.size(); g++) {
						String compare2 = inputWords2.get(g);
						if(compare1.equals(compare2)) {
							unique = false;
							break;
						}
						else {
							unique = true;
						}
					}
					if (unique == false) {
						break;
					}
					else {
						inputWords2.remove(i);
						i = i - 1;
					}
				}
				return unique;
			}
			public static boolean isEnglishWord(ArrayList<String> inputWords, ArrayList<String> wordList) {
				boolean isEnglish = false;
				double number;
				for(int i = 0; i<inputWords.size(); i++) {
					String word1 = inputWords.get(i);
					number = binarySearch(wordList, word1);
					if(number>= 0) {
						isEnglish = true;
					}
					else {
						isEnglish =  false;
						break;
					}
				
				}
				return isEnglish;
			}
			public static boolean isDifferentByOne(ArrayList<String> inputWords) {
				ArrayList<String> inputWords3 = new ArrayList<String>();
				for(int a = 0; a < inputWords.size(); a++) {
					inputWords3.add(inputWords.get(a));
				}
				int length = inputWords3.get(0).length();
				boolean sameLength = true;
				for(int i = 0; i<inputWords3.size(); i++) {
					int length2 = inputWords3.get(i).length();
					if(length == length2){
						sameLength = true;
					}
					else {
						sameLength = false;
						break;
						}
					}
				if(sameLength == true) {
				for(int g = 0, b = 1; g<inputWords3.size() && b<inputWords3.size(); g++, b++) {
					String word1 = inputWords3.get(g);
					String word2 = inputWords3.get(b);
					int letter = 0;
					for (int y = 0; y < inputWords3.get(0).length(); y++) {
			            int charWord1 = (int) word1.charAt(y);
			            int charWord2 = (int) word2.charAt(y);
			            if (charWord1 != charWord2) {
			              letter = letter + 1;  
			            }
			            if(letter >= 2) {
			            	sameLength = false;
			            	break;
			            	}
			            else {
			            	sameLength = true;
			            	}
			        	}
					if(sameLength == false) {
						break;
						}
					}
				}
				if(sameLength == false) {
					return sameLength;
				}
					return sameLength;
			}
			public static int binarySearch(ArrayList<String> wordList, String word){
			     int i = 0;
			     int size = wordList.size()- 1;
			     while (i <= size) {   
			        	int index = i + (size - i)/2;
			        	int number = word.compareTo(wordList.get(index));
			            	if(number == 0){
			            		return index;
			            	}
			            	if (number > 0) {
			            		i = index + 1;
			            	}
			            	else {
			            		size = index - 1;
			            	}
			        	}
			     	return -1;
			    }
			
		/* SELF ASSESSMENT 
		1. readDictionary
		- I have the correct method definition [Mark out of 5:5]
		- Comment: I have the correct method definition.
		- My method reads the words from the "words.txt" file. [Mark out of 5:5]
		- Comment: My method reads the words from the "words.txt" file.
		- It returns the contents from "words.txt" in a String array or an ArrayList. [Mark out of 5:5]
		- Comment: It returns the contents from "words.txt" in a String array or an ArrayList.

		2. readWordList
		- I have the correct method definition [Mark out of 5:5]
		- Comment: I have the correct method definition 
		- My method reads the words provided (which are separated by commas, saves them to an array or ArrayList of String references and returns it. [Mark out of 5:5]
		- Comment: My method reads the words provided (which are separated by commas, saves them to an array or ArrayList of String references and returns it.
		I am not sure if the words are supposed to be separated purely by commas or space after comma however, it says that its separated by commas so I implemented to work with purely commas.

		3. isUniqueList
		- I have the correct method definition [Mark out of 5:5]
		- Comment: I have the correct method definition 
		- My method compares each word in the array with the rest of the words in the list. [Mark out of 5:5]
		- Comment: My method compares each word in the array with the rest of the words in the list. 
		- Exits the loop when a non-unique word is found. [Mark out of 5:5]
		- Comment: Exits the loop when a non-unique word is found. [Mark out of
		- Returns true is all the words are unique and false otherwise. [Mark out of 5:5]
		- Comment: Returns true is all the words are unique and false otherwise. 

		4. isEnglishWord
		- I have the correct method definition [Mark out of 5:5]
		- Comment: I have the correct method definition
		- My method uses the binarySearch method in Arrays library class. [Mark out of 3:3]
		- Comment: My method uses the binarySearch method in Arrays library class.
		- Returns true if the binarySearch method return a value >= 0, otherwise false is returned. [Mark out of 2:2]
		- Comment: Returns true if the binarySearch method return a value >= 0, otherwise false is returned.

		5. isDifferentByOne
		- I have the correct method definition [Mark out of 5:5]
		- Comment: I have the correct method definition
		- My method loops through the length of a words comparing characters at the same position in both words searching for one difference. [Mark out of 10:10]
		- Comment: My method loops through the length of a words comparing characters at the same position in both words searching for one difference.

		6. isWordChain
		- I have the correct method definition [Mark out of 5:5]
		- Comment: I have the correct method definition
		- My method calls isUniqueList, isEnglishWord and isDifferentByOne methods and prints the appropriate message [Mark out of 10:10]
		- Comment: My method calls isUniqueList, isEnglishWord and isDifferentByOne methods and prints the appropriate message 

		7. main
		- Reads all the words from file words.txt into an array or an ArrayList using the any of the Java.IO classes covered in lectures [Mark out of 10:]
		- Comment: Reads all the words from file words.txt into an array or an ArrayList using the any of the Java.IO classes covered in lectures 
		- Asks the user for input and calls isWordChain [Mark out of 5:5]
		- Comment: Asks the user for input and calls isWordChain

		 Total Mark out of 100 (Add all the previous marks):100
		*/
	}

