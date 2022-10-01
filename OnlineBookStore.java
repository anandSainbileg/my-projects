import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class OnlineBookStore
{
    public static int ISBN_INDEX = 0;
    public static int TITLE_INDEX = 1;
    public static int AUTHOR_INDEX = 2;
    public static int PUBLISHER_INDEX = 3;
    public static int PUBLISHER_YEAR_INDEX = 4;
    public static int QUANTITY_INDEX = 5;
    public static int PRICE_INDEX = 6;

    public static void main(String[] args)
    {
	ArrayList<Book> bookList = new ArrayList<Book>();
	try
	{
	    FileReader fileReader = new FileReader("books.txt");// Enter the entire path of the file if needed
	    BufferedReader bufferedReader = new BufferedReader(fileReader);  
	    boolean endOfFile = false;

	    while(!endOfFile)
	    {
                String bookLine = bufferedReader.readLine();
	        if (bookLine != null)
		{
	            String[] bookData = bookLine.split(", ");
	            String isbn = bookData[ISBN_INDEX];
	            String title = bookData[TITLE_INDEX];
	            String author = bookData[AUTHOR_INDEX];
	            String publisher = bookData[PUBLISHER_INDEX];
	            int publishYear = Integer.parseInt (bookData[PUBLISHER_YEAR_INDEX]);
	            int quantity = Integer.parseInt (bookData[QUANTITY_INDEX]);
	            double price = Double.parseDouble (bookData[PRICE_INDEX]);
	            Book book = new Book(isbn, title, author, publisher, publishYear, quantity, price);
	            bookList.add(book);

	         }
		 else
		 {
	            endOfFile = true;
	         }
	    }
	         bufferedReader.close();    
	         fileReader.close();
        } // End try 

	catch (FileNotFoundException e)
	{
	    e.printStackTrace();
	}
	catch (IOException e)
	{
	    e.printStackTrace();
	}

	// Uncomment the following lines once you have implemented the required methods
	printBookDetails(bookList);
	System.out.print("\n");
	purchaseBook(bookList);
	
    }
    public static void printBookDetails(ArrayList<Book> bookList) {
    	Book myBook = new Book();
    	for(int i = 0; i<bookList.size(); i++) { 
    		myBook = bookList.get(i);
    	System.out.println(myBook.toString());
    	}
    }
    public static void topUpCard(ChargeCard card, double amount) {
    	card.topUpFunds(amount);
    }
    public static Book getBook(ArrayList<Book> bookList, String title) {
    	Book myBook = null;
    	for(int i = 0; i< bookList.size(); i++) {
    		String title2 = bookList.get(i).getTitle();
    		if(title.equalsIgnoreCase(title2)) {
    			myBook = bookList.get(i);
    			break;
    			}
    		else {
    			
    			
    		}
    	}
    	return(myBook);
   }
    
    public static void purchaseBook(ArrayList<Book> bookList) {
    	Scanner input = new Scanner(System.in);
    	boolean finish = false;
    	Book myBook = new Book();
    	ChargeCard myCard = new ChargeCard();
    	System.out.println("How much would you like to top up your card:");
    	while(!finish) {
    	if(input.hasNextDouble()) {
    	double amount = input.nextDouble();
    	input.nextLine();
    	topUpCard(myCard, amount);
    	finish = true;
    	}
    	else {
    		System.out.println("Please enter a number");
    		input.nextLine();
    		}
    	}
    	while(myCard.getFunds() >= 15.50) {
    	System.out.println("Choose the book name you want to purchase:");
    	String title = "";
    	title+=input.nextLine();
        
    	myBook = getBook(bookList, title);
    	if(myBook != null && myCard.getFunds() >= myBook.getPrice() && myBook.getQuantity() > 0) {
    	System.out.println("You have purchased:");
    	System.out.println(myBook.toString());
    	myBook.setQuantity(myBook.getQuantity() - 1);
    	myCard.setFunds(myCard.getFunds() - myBook.getPrice());
    	System.out.printf("You have: %.2f", myCard.getFunds());
    	System.out.println("\n");
    	}
    	else {
    		System.out.println("Sorry there's no book named " + title + " Or you don't have enough money");
    		}
    	}
    	System.out.println("Insufficient amount of money to buy a book ");
    }
}
public class Book
{
    private String isbn;
    private String title;
    private String author;
    private String publisher;
    private int publishYear;
    private int quantity;
    private double price;
	
    public Book()
    {
		
    }
	
    public Book(String new_isbn, String new_title, String new_author, String new_publisher, int new_publishYear, int new_quantity, double new_price)
    {
    isbn = new_isbn;
	title = new_title;
	author = new_author;
	publisher = new_publisher;
	publishYear = new_publishYear;
	quantity = new_quantity;
	price = new_price;
    }
	
    public int getPublishYear()
    {
	return publishYear;
    }

    public void setPublishYear(int new_publishYear)
    {
	publishYear = new_publishYear;
    }

    public int getQuantity()
    {
	return quantity;
    }

    public void setQuantity(int new_quantity)
    {
	quantity = new_quantity;
    }

    public double getPrice()
    {
	return price;
    }

    public void setPrice(double new_price)
    {
	price = new_price;
    }

    public String getIsbn()
    {
	return isbn;
    }

   public void setIsbn(String new_isbn)
   {
	isbn = new_isbn;
   }

   public String getTitle()
   {
        return title;
   }

   public void setTitle(String new_title)
   {
	title = new_title;
   }

   public String getAuthor()
   {
	return author;
   }

   public void setAuthor(String new_author)
   {
	author = new_author;
   }

   public String getPublisher()
   {
	return publisher;
   }

   public void setPublisher(String new_publisher)
   {
	publisher = new_publisher;
   }

   @Override
   public String toString()
   {
	return "isbn: " + isbn + ", Title: " + title + ", Author: " + author + ", Publisher: " + publisher + ", PublishYear: " + publishYear + ", Quantity: " + quantity + ", Price: " + price + "\n\n";
   }
	
}

public class ChargeCard
{
	
    private double funds;
	
    public ChargeCard()
    {
	funds = 0.0;
    }
	
    public void topUpFunds(double new_funds)
    {
	funds += new_funds;
    }
	
    public void removeFunds(double new_funds)
    {
	funds -= new_funds;
    }

    public double getFunds()
    {
	return funds;
    }

    public void setFunds(double new_funds)
    {
	funds = new_funds;
    }
}

