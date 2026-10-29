import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

class Calc extends JFrame  implements ActionListener {
	static JButton one, two, three, four, five, six, seven, eight, nine, zero;
   static JButton plus, minus, multiply, divide, equalsTo, decimal, clear;
   static JTextField  stuff;
   static JLabel warning;
	static JPanel p1, p2;
   static double total;
   static boolean operator;
   static String prev = "";
	
	Calc(){
      super();
        setTitle("My calculator");
        setSize(500, 350);
        setLayout(new BorderLayout());

        // Create buttons
        one = new JButton("1");
        two = new JButton("2");
        three = new JButton("3");
        four = new JButton("4");
        five = new JButton("5");
        six = new JButton("6");
        seven = new JButton("7");
        eight = new JButton("8");
        nine = new JButton("9");
        zero = new JButton("0");
        plus = new JButton("+");
        minus = new JButton("-");
        multiply = new JButton("*");
        divide = new JButton("/");
        equalsTo = new JButton("=");
        decimal = new JButton(".");
        clear = new JButton("clear");

        
        // Create panels
        p1 = new JPanel();
        p1.setLayout(new GridLayout(4,4));
        p2 = new JPanel();
        p2.setLayout(new FlowLayout());
        add(p2, BorderLayout.SOUTH);
        add(p1);
        

        // Add buttons to panels
        p1.add(nine);
        p1.add(eight);
        p1.add(seven);
        p1.add(plus);
        p1.add(six);
        p1.add(five);
        p1.add(four);
        p1.add(minus);
        p1.add(three);
        p1.add(two);
        p1.add(one);
        p1.add(multiply);
        p1.add(zero);
        p1.add(decimal);
        p1.add(equalsTo);
        p1.add(divide);
        // Create text field and warning label
        stuff = new JTextField(20);
        warning = new JLabel();

        // Add panels, text field, and warning label to the frame
        
        p2.add(stuff, BorderLayout.EAST);
        p2.add(clear,BorderLayout.CENTER);
        p2.add(warning, BorderLayout.WEST);
        setVisible(true);
      // Add action listeners
        one.addActionListener(this);
        two.addActionListener(this);
        three.addActionListener(this);
        four.addActionListener(this);
        five.addActionListener(this);
        six.addActionListener(this);
        seven.addActionListener(this);
        eight.addActionListener(this);
        nine.addActionListener(this);
        zero.addActionListener(this);
        plus.addActionListener(this);
        minus.addActionListener(this);
        multiply.addActionListener(this);
        divide.addActionListener(this);
        equalsTo.addActionListener(this);
        decimal.addActionListener(this);
        clear.addActionListener(this);

	   someotherclass obj=new someotherclass();
      
      
		plus.addActionListener(obj);
      minus.addActionListener(obj);
      multiply.addActionListener(obj);
      divide.addActionListener(obj);
      clear.addActionListener(obj);
		//add textfield, button and label to the panel2 
	   //place panel2 on the frame
      
	
	}
   public static void main(String [] args){
      Calc myCal = new Calc();
      myCal.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      
   }	
	public void actionPerformed ( ActionEvent e   ){
		  String action = e.getActionCommand();

        if (action.equals("clear")) {
            warning.setText("");
            stuff.setText("");
            operator = false;
        } else {
            if (operator) {
                warning.setText("Warning: Invalid input!");
                return;
            }

            String text = stuff.getText();
            text += action;
            stuff.setText(text);
        }

         //clear warning label
			//if ()
				//clear the textbox
			//set the textbox = grab what is in the textbox  + whatever is the label of the button that was just pressed 
			//operator = false;
			//populate textbox;
	}
}


	/*	clear textbox
			give warning if an operator is chosen again and operator flag is true
			operator=true
			next= the operator that was pressed
			if prev is plus
				add total to what is in textbox and update total
			else if ???
				...
			
			update textbox with value of total
			prev=next
	*/

class someotherclass implements ActionListener {
    static double total;
    static boolean operator;
    static String prev;

    public void actionPerformed(ActionEvent e) {
        String action = e.getActionCommand();

        if (action.equals("clear")) {
            Calc.warning.setText("");
            Calc.stuff.setText("");
            operator = false;
        } else {
            if (operator) {
                Calc.warning.setText("Can't choose an operator again!");
                return;
            }

            String text = Calc.stuff.getText();
            text += action;
            Calc.stuff.setText(text);
        }

        if (action.equals("+")) {
            operator = true;
            performOperation("+");
        } else if (action.equals("-")) {
            operator = true;
            performOperation("-");
        } else if (action.equals("*")) {
            operator = true;
            performOperation("*");
        } else if (action.equals("/")) {
            operator = true;
            performOperation("/");
        }
    }

    private void performOperation(String operator) {
        String text = Calc.stuff.getText();
        double value = Double.parseDouble(text);

        if (prev != null) {
            if (prev.equals("+")) {
                total += value;
            } else if (prev.equals("-")) {
                total -= value;
            } else if (prev.equals("*")) {
                total *= value;
            } else if (prev.equals("/")) {
                total /= value;
            }
        } else {
            total = value;
        }
        
        prev = operator;
        Calc.stuff.setText(String.valueOf(total));
    }
}