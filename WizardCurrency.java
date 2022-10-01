import java.util.Scanner;
import java.lang.Math;
public class WizardCurrency {

	public WizardCurrency() {
	}

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		boolean end = false;
		while(!end) {
		System.out.println("1. Convert Wizarding Currency To GBP");
		System.out.println("2. Convert Knuts To Wizarding Currency and GBP");
		System.out.println("3. Convert GBP to Wizarding Currency");
		System.out.println("4. Quit");
		String prompt = "Select function> ";
		String errorMessage = "Error: Invalid selection.\n";
		boolean integerRequired = false;
		double functionNumber = 0;
		boolean endfirst = false;
		
		functionNumber = getNumberFromUser(prompt, errorMessage,input, integerRequired);
		
		
		int fNumber = (int) functionNumber;
		switch(fNumber) {
		case 1: integerRequired = true;
			prompt = "Enter the number of Galleons > ";
			errorMessage = "Error: The number of Galleons should be an integer (e.g. 3)\n";
			int numGalleons = (int) getNumberFromUser(prompt, errorMessage, input, integerRequired);
			prompt = "Enter the number of Sickles > ";
			errorMessage = "Error: The number of Sickles should be an integer (e.g. 5)\n";
			int numSickles = (int) getNumberFromUser(prompt, errorMessage,input, integerRequired );
			prompt = "Enter the number of Knuts > ";
			errorMessage = "Error: The number of Knuts should be an integer (e.g. 12)\n";
			int numKnuts = (int) getNumberFromUser(prompt, errorMessage,input, integerRequired );
			int totalPence = convertWizardingCurrencyToPence(numGalleons, numSickles, numKnuts );
			double GBP = (double) totalPence / 100.0;
			System.out.println("In British Pounds HP" + numGalleons + ":" + numSickles + ":" + numKnuts + " is GBP" + GBP);
		break;
		
		case 2: integerRequired = true;
			prompt = "Enter the number of Knuts > ";
			errorMessage = "Error: The number of Knuts should be an integer (e.g. 56)\n";
			int Knuts = 0;
			int Galleons = 0;
			int Sickles = 0;
			int totalKnuts = (int) getNumberFromUser(prompt, errorMessage,input, integerRequired );
			String KnutsToWizard = convertKnutsToWizardingCurrency(totalKnuts);
			double GBpound = (double) totalKnuts / (812.0/499.0);
			GBpound = Math.round(GBpound);
			GBpound = GBpound / 100.0;
			System.out.println(totalKnuts + " knuts is " + KnutsToWizard + " is equal to GBP" + GBpound);
		break;
		
		case 3: integerRequired = false;
		prompt = "Enter the number of British pounds and pence (e.g. 1.24) > ";
		errorMessage = "Error: Invalid number of British pounds and pence\n"; 
		double penceDouble = getNumberFromUser(prompt, errorMessage, input, integerRequired );
		int pounds = (int) penceDouble;
		double penceDec = penceDouble - pounds;
		penceDec = penceDec * 100;
		int pence = (int) penceDec;
		String GBPtoHP = convertGBPToWizardingCurrency(pounds, pence );
		double penceD = pounds + pence / 100.0;
		System.out.println("In wizarding currency GBP" + penceD + " is " + GBPtoHP);
		break;
		case 4: 
			end = true;
			return;
		default:
			errorMessage = "Error: Invalid selection.\n";
			System.out.print(errorMessage);
			
			}
		}
	}
	
	public static int convertGBPToKnuts( int pounds, int pence ) {
		int totalPence = (pounds * 100) + (pence);
		double theKnuts = (812.0/499.0) * totalPence;
		int Knuts = (int) Math.round(theKnuts);
		return (Knuts);
		
	}
	
	public static String convertKnutsToWizardingCurrency( int totalKnuts ){
		
		int remainder = totalKnuts % 493;
		int Galleons = (totalKnuts - remainder) / 493;
		int sicklesRemainder = remainder % 29;
		int Sickles = (remainder - sicklesRemainder) / 29;
		int Knuts = sicklesRemainder;
		String KnutsToWizard = "HP" + Galleons +":" + Sickles + ":" + Knuts; 
		return(KnutsToWizard);
	}
	
	public static String convertGBPToWizardingCurrency( int pounds, int pence ) {
		int totalKnuts = convertGBPToKnuts(pounds, pence);
		int remainder = totalKnuts % 493;
		int Galleons = (totalKnuts - remainder) / 493;
		int sicklesRemainder = remainder % 29;
		int Sickles = (remainder - sicklesRemainder) / 29;
		int Knuts = sicklesRemainder;
		 
		String GBPtoHP = "HP" + Galleons + ":" + Sickles + ":" + Knuts;
		return(GBPtoHP);
	}
	
	public static int convertWizardingCurrencyToKnuts( int numGalleons, int numSickles, int numKnuts ) {
		Scanner input = new Scanner(System.in);
		int totalKnuts = (numGalleons * 493) + (numSickles * 29) + numKnuts;
		return (totalKnuts);
	}
	
	public static int convertWizardingCurrencyToPence( int numGalleons, int numSickles, int numKnuts ) {
		
		
		int totalKnuts = convertWizardingCurrencyToKnuts(numGalleons, numSickles, numKnuts);
		double totalPence = (double) totalKnuts / (812.0/499.0);
		int totalPenceInt = (int)Math.round(totalPence);
		double GBP = totalPenceInt / 100.0;
		return(totalPenceInt);
	}
		
	
	public static double getNumberFromUser( String prompt, String errorMessage, Scanner input, boolean integerRequired ) {
		double integer = 0;
		boolean finish = false;
		while(!finish)
		{
		System.out.print(prompt);
		if(integerRequired == true) {
			
			if(input.hasNextInt()) {
			integer = input.nextInt();
			finish = true;
			 input.nextLine();
			}
			else {
				System.out.print(errorMessage);
				finish = false;
				input.nextLine();
			}
			}
		else {
			if(input.hasNextDouble()) {
				integer = input.nextDouble();
				finish = true;
				input.nextLine();
			}
			else {
				System.out.print(errorMessage);
				finish = false;
				input.nextLine();
			}
		}
			
		}
		return (integer);
			
		}
	}

