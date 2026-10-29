import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.text.DecimalFormat;

/**
 * Simple calculator GUI (originally designed as an applet panel).
 * User enters two real numbers and clicks +, -, *, / (and Clear) to compute.
 * Panel is sized to about 300 by 160 pixels.
 *
 * Note: Applets are deprecated; this code runs cleanly as a desktop app.
 */
public class SimpleCalc extends JApplet {

    /**
     * Stand-alone entry point.
     */
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            JFrame window = new JFrame("Simple Calculator");
            CalcPanel content = new CalcPanel();
            window.setContentPane(content);
            window.pack(); // sizes to preferred size
            window.setLocation(100, 100);
            window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            window.setVisible(true);
        });
    }

    /**
     * Applet entry point (kept for compatibility with the original assignment).
     */
    @Override
    public void init() {
        setContentPane(new CalcPanel());
    }

    public static class CalcPanel extends JPanel implements ActionListener {

        private final JTextField xInput, yInput;
        private final JLabel answer;

        // Format results nicely (avoid showing 0.3333333333333 etc.)
        private final DecimalFormat fmt = new DecimalFormat("0.##########");

        public CalcPanel() {

            setBackground(Color.GRAY);
            setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));

            xInput = new JTextField("0", 10);
            xInput.setBackground(Color.WHITE);

            yInput = new JTextField("0", 10);
            yInput.setBackground(Color.WHITE);

            JPanel xPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
            xPanel.setOpaque(false);
            xPanel.add(new JLabel(" x = "));
            xPanel.add(xInput);

            JPanel yPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
            yPanel.setOpaque(false);
            yPanel.add(new JLabel(" y = "));
            yPanel.add(yInput);

            JPanel buttonPanel = new JPanel(new GridLayout(1, 5, 3, 3));
            buttonPanel.setOpaque(false);

            JButton plus = new JButton("+");
            plus.addActionListener(this);
            buttonPanel.add(plus);

            JButton minus = new JButton("-");
            minus.addActionListener(this);
            buttonPanel.add(minus);

            JButton times = new JButton("*");
            times.addActionListener(this);
            buttonPanel.add(times);

            JButton divide = new JButton("/");
            divide.addActionListener(this);
            buttonPanel.add(divide);

            JButton clear = new JButton("C");
            clear.setToolTipText("Clear inputs");
            clear.addActionListener(this);
            buttonPanel.add(clear);

            answer = new JLabel("x + y = 0", JLabel.CENTER);
            answer.setForeground(Color.RED);
            answer.setBackground(Color.WHITE);
            answer.setOpaque(true);
            answer.setFont(answer.getFont().deriveFont(Font.BOLD, 12f));

            setLayout(new GridLayout(4, 1, 3, 3));
            add(xPanel);
            add(yPanel);
            add(buttonPanel);
            add(answer);

            xInput.requestFocus();

            // Preferred size near 300x160 as the assignment specifies
            setPreferredSize(new Dimension(300, 160));
        }

        @Override
        public void actionPerformed(ActionEvent evt) {

            String op = evt.getActionCommand();

            // Clear behavior
            if ("C".equals(op)) {
                xInput.setText("0");
                yInput.setText("0");
                answer.setText("Cleared. Enter values.");
                xInput.requestFocus();
                xInput.selectAll();
                return;
            }

            double x, y;

            try {
                x = Double.parseDouble(xInput.getText().trim());
            } catch (NumberFormatException e) {
                answer.setText("Illegal data for x.");
                xInput.requestFocus();
                xInput.selectAll();
                return;
            }

            try {
                y = Double.parseDouble(yInput.getText().trim());
            } catch (NumberFormatException e) {
                answer.setText("Illegal data for y.");
                yInput.requestFocus();
                yInput.selectAll();
                return;
            }

            switch (op) {
                case "+":
                    answer.setText("x + y = " + fmt.format(x + y));
                    break;
                case "-":
                    answer.setText("x - y = " + fmt.format(x - y));
                    break;
                case "*":
                    answer.setText("x * y = " + fmt.format(x * y));
                    break;
                case "/":
                    if (y == 0.0) {
                        answer.setText("Can't divide by zero!");
                    } else {
                        answer.setText("x / y = " + fmt.format(x / y));
                    }
                    break;
                default:
                    answer.setText("Unknown operation.");
            }
        }
    }
}
