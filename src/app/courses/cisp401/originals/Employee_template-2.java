import java.util.*;
import java.text.*;

abstract class Employee {
   public String empName;
   public double hrlyPay;
   public double annualPay;
   public int empCount;
   {
         empCount++;
   }
   public void setEmpName(String empName){
      this.empName = empName;
   }
   public String getEmpName(){
      return empName;
   }
   public void setHrlyPay(double hrlyPay){
      this.hrlyPay = hrlyPay;
   }
   public double getHrlyPay(){
      return hrlyPay;
   }
   public void setannualPay(double annualPay){
      this.annualPay = annualPay;
   }
   public double getannualPay(){
      return annualPay;
   }

   public int getEmpCount(){
      return empCount;
   }
   abstract double computePay(double hoursWorked); 
   public void risePay(double percent){
      hrlyPay += ((hrlyPay/100)*percent);
      annualPay += ((annualPay/100)*percent);
   }
}

// -----------------------------------------------------------------------------------------------------------------------------

class HourlyEmployee extends Employee { 
   double hoursWorked; 
   HourlyEmployee(String empName, double hrlyPay) {
      super.setEmpName(empName);
      super.setHrlyPay(hrlyPay);
   }
   
   double computePay(double hoursWorked) { 
      this.hoursWorked = hoursWorked;
      double pay;
      if(hoursWorked > 40){
         pay = (((super.hrlyPay) * (hoursWorked)) + ((1.0/2.0)*(super.hrlyPay) * (hoursWorked - 40)));
      }
      else {
         pay = ((super.hrlyPay) * (hoursWorked));
      }
      return pay;
   }
}

// -----------------------------------------------------------------------------------------------------------------------------

class SalariedEmployee extends Employee { 
   double pay;
   double hrlyPay;   
   double annualSalary;
   double hoursWorked = 40.0;
   SalariedEmployee(String empName, double annualSalary) { 
      super.setEmpName(empName);
      super.setannualPay(annualSalary);
      this.annualSalary = annualSalary;   
      hrlyPay = ((annualSalary/52)/hoursWorked);
      super.setHrlyPay(hrlyPay);
   }
   
   double computePay(double hoursWorked) {
      this.hoursWorked = hoursWorked;  
      pay = annualSalary / 52;
      hrlyPay = (annualSalary / 52)/ hoursWorked;
      super.setHrlyPay(hrlyPay);
      return pay;
   }
}

// -----------------------------------------------------------------------------------------------------------------------------

class EmployeeDriver {
   static int index = 0;
   static Employee[] emps =  new Employee[1];
   static Scanner scnr = new Scanner(System.in);
   public static void main(String[] args) { 

      String command;
      boolean quit = false;
      
      do{
         employeeMenu();
         System.out.println("");
         System.out.println("Enter command: ");
         command = scnr.next();
         if(command.equals("Q")||command.equals("q")){
            quit = true;
         }
         else 
            select(command);
      }while(!quit);
      
   }
   public static void employeeMenu(){
      System.out.println("N: New employee");
	   System.out.println("P: Compute paychecks");
	   System.out.println("R: Raise wages");
	   System.out.println("L: List all employees");
	   System.out.println("Q: Quit");
   }
   
   public static void select (String user) {
      switch (user.toUpperCase()){
         case "N":    newEmployee();
                      break;
         case "P":    computePaycheck();
                      break;
         case "R":    raiseWages();
                      break;
         case "L":    listEmployees();
                      break;
      }
   }
   public static void newEmployee() {
     System.out.println("Enter first name of new employee: ");
     String name;
     char HorS;
     double hrlyPay, annualSalary;
     hrlyPay = 0.00;
     annualSalary = 0.00;
     scnr.nextLine();
     name = scnr.nextLine();
     System.out.println("Hourly (h) or salaried (s): ");
     HorS = scnr.next().charAt(0);
     if(index == emps.length){
         Employee[] empstemp = new Employee[emps.length * 2];
         System.arraycopy(emps,0,empstemp,0, emps.length);
         emps = empstemp;
     }
     if(HorS == 'h'){
        System.out.println("Enter hourly wage: ");
        hrlyPay = scnr.nextDouble();
        emps[index] = new HourlyEmployee(name, hrlyPay);
        ++index;
     }
     else if(HorS == 's'){
        System.out.println("Enter annual salary: ");
        annualSalary = scnr.nextDouble();
        emps[index] = new SalariedEmployee(name, annualSalary);
        ++index;
     }  
   }
      
   public static void computePaycheck() {
      double hoursWorked = 0.00;
      double pay =0.0;
      NumberFormat c = NumberFormat.getCurrencyInstance();
      c.setMaximumFractionDigits(2);
      for(int i =0; i < emps.length; ++i){
         System.out.println("Enter number of hours worked per week by " + emps[i].getEmpName() + ": ");
         hoursWorked = scnr.nextDouble();
         if(emps[i] instanceof HourlyEmployee){
            pay = ((HourlyEmployee)emps[i]).computePay(hoursWorked);
            System.out.println("Pay: " + c.format(pay));
         }
         else if(emps[i] instanceof SalariedEmployee){
           pay = ((SalariedEmployee)emps[i]).computePay(hoursWorked);
           System.out.println("Pay: " + c.format(pay)); 
         }
         System.out.println("");
      }
   }   
   
   public static void raiseWages() {
     //grab percentage and raise wages for all employees. This means that the hourly pay for
     double percent;
     NumberFormat c = NumberFormat.getCurrencyInstance();
     c.setMaximumFractionDigits(2);
     System.out.println("Enter percentage increase: ");
     percent = scnr.nextDouble();
     System.out.printf("%-25s      %s    %n","Name", "New Wages");
     System.out.printf("%-25s      %s     %n","---------------", "-----------------");
     for(int i=0; i<emps.length; ++i){
        if(emps[i] instanceof HourlyEmployee){
           ((HourlyEmployee)emps[i]).risePay(percent);
           System.out.printf("%-25s      %s/hour    %n",emps[i].getEmpName(),c.format(emps[i].getHrlyPay()));
        }
        else if(emps[i] instanceof SalariedEmployee){
           ((SalariedEmployee)emps[i]).risePay(percent);
           System.out.printf("%-25s      %s/year    %n",emps[i].getEmpName(),c.format(emps[i].getannualPay())); 
         }
     }
     //each employee will be raised by the inputted percentage
   }
   public static void listEmployees() {
     NumberFormat c = NumberFormat.getCurrencyInstance();
     c.setMaximumFractionDigits(2);
     System.out.printf("%-25s      %s    %n","Name", "hourly wages");
     System.out.printf("%-25s      %s     %n","---------------", "-----------------");
     for(int i=0; i<emps.length; ++i){
        if(emps[i] instanceof HourlyEmployee){
           System.out.printf("%-25s      %s/hour    %n",emps[i].getEmpName(),c.format(emps[i].getHrlyPay()));
        }
        else if(emps[i] instanceof SalariedEmployee){
           System.out.printf("%-25s      %s/hour    %n",emps[i].getEmpName(),c.format(emps[i].getHrlyPay())); 
        }
      }
    }
}