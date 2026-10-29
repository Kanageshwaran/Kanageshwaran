import java.util.*;
public class Bank {
  static BankAccount[] accounts; 
  static int noOfAccs;
  Scanner scnr = new Scanner(System.in);           
  
  public static void main(String[] args) { 
	bankMenu(); 
   }
  
  static void bankMenu(){
    int currentIndex = -1;	
    char userSelection;
    BankAccount[] accounts = new BankAccount[2];
    noOfAccs = 0;
    boolean quit = false;
    boolean duplicate;
    do{  
      printMenu(currentIndex);
      System.out.println("Enter command: ");
      Scanner scnr = new Scanner(System.in);
      userSelection = scnr.next().charAt(0);
      switch(userSelection) {
        case 'O': //Open account
          if(currentIndex == accounts.length){
            resize(accounts);
          }
          currentIndex += 1;
          accounts[currentIndex] = openAcc(currentIndex);//make sure you have enough space or double size OF accounts array
		    //make sure the account number is not a duplicate. Assign array index to account
          //set the current index;
          noOfAccs++;//increment the number of accounts
        case 'D': //Deposit 
          if(currentIndex == -1){
            System.out.println("Please select an account");
          }
          else{
            System.out.println("Enter amount of deposit: ");
            double deposit;
            deposit = scnr.nextDouble();
            accounts[currentIndex].deposit(deposit);
          }         
        case 'S': //Select account
          //look for account and if it exists, set currentIndex to it          
        case 'C': //Close account
          //if currentindex is not -1 close the account and reset currentIndex		            
        case 'W': //Withdraw
          if(currentIndex == -1){
            System.out.println("Please select an account");
          }
          else{
            System.out.println("Enter amount to withdraw: ");
            double withdraw;
            withdraw = scnr.nextDouble();
            if(withdraw < accounts[currentIndex].getBalance()){
              accounts[currentIndex].withdraw(withdraw); 
            }
            else{
               System.out.println("You are withdrawing too much: try again");
            }
          }
        case 'L': //List accounts
          //traverse through all the accounts and display their information
          break;
        case 'Q':
          quit = true;
      }
    }while(!quit);
  }

  static void printMenu(int index){
      System.out.println("            	O: Open account");
		System.out.println("            	D: Deposit");
		System.out.println("            	S: Select account");
		System.out.println("            	C: Close account");
		System.out.println("            	W: Withdraw");
		System.out.println("            	L: List all accounts");
		System.out.println("            	Q: Quit");
      System.out.println();
      if(index == -1){
         System.out.println("current account selected: NONE");
         System.out.println("");
      }
      else{
         System.out.print("current account selected: " + accounts[index].getAcc() + "	Balance: $" + accounts[index].getBalance());
         System.out.println("");
      }   
  }

 
  static BankAccount openAcc(int index){
    //Grab account number
              //validate for duplicate account number 
		    //Grab balance
    //create new account and return the object so that the array index can point to the 
    return accounts[index];//newly created object
  }
  
  static BankAccount[] resize(BankAccount[] a){
      BankAccount[] temp = new BankAccount[a.length *2];
      System.arraycopy(a,0,temp,0, a.length);
      a = temp;
      return a;
   }

  static void listAccounts(){
	//Go through all the accounts using a for loop and display their content
  }

  static int selectAcc(){
    int index = 0;
    return index;//ask for the account number, check to see if it exists and return index
  }
  
  static void closeAcc(int index){
    //move last account to the index that needs to be deleted 
    //set last account to null
    //decrement noOfAccts variable
  }
}

class BankAccount{
  private int accNbr;
  private double balance;
  
  BankAccount(int accNbr, double balance){
    this.accNbr = accNbr;
    this.balance = balance;
  }
  
  int getAcc(){
    return accNbr;
  }
  
  double getBalance(){
   return balance;
  }
  
  
  void deposit(double deposit){     
	balance += deposit;  
  }
  
  void withdraw (double withDraw){
      balance -= withDraw;
  }
}
