import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;

public class AppGUI extends JFrame implements ActionListener {
    private final JLabel studentIdLabel, firstNameLabel, lastNameLabel, majorLabel, phoneLabel, gpaLabel, dobLabel;
    private final JTextField studentIdField, firstNameField, lastNameField, majorField, phoneField, gpaField, dobField;
    private final JButton addButton, displayButton, sortButton, searchButton, modifyButton;

    private Connection conn;
    private PreparedStatement pstmt;

    public AppGUI() {
        // Initialize labels
        studentIdLabel = new JLabel("Student ID:");
        firstNameLabel = new JLabel("First Name:");
        lastNameLabel = new JLabel("Last Name:");
        majorLabel = new JLabel("Major:");
        phoneLabel = new JLabel("Phone:");
        gpaLabel = new JLabel("GPA:");
        dobLabel = new JLabel("Date of Birth (yyyy-mm-dd):");

        // Initialize text fields
        studentIdField = new JTextField(10);
        firstNameField = new JTextField(10);
        lastNameField = new JTextField(10);
        majorField = new JTextField(10);
        phoneField = new JTextField(10);
        gpaField = new JTextField(10);
        dobField = new JTextField(10);

        // Initialize buttons
        addButton = new JButton("Add");
        displayButton = new JButton("Display");
        sortButton = new JButton("Sort");
        searchButton = new JButton("Search");
        modifyButton = new JButton("Modify");

        // Add action listeners to buttons
        addButton.addActionListener(this);
        displayButton.addActionListener(this);
        sortButton.addActionListener(this);
        searchButton.addActionListener(this);
        modifyButton.addActionListener(this);

        // Create panel and add components
        JPanel panel = new JPanel();
        panel.add(studentIdLabel);
        panel.add(studentIdField);
        panel.add(firstNameLabel);
        panel.add(firstNameField);
        panel.add(lastNameLabel);
        panel.add(lastNameField);
        panel.add(majorLabel);
        panel.add(majorField);
        panel.add(phoneLabel);
        panel.add(phoneField);
        panel.add(gpaLabel);
        panel.add(gpaField);
        panel.add(dobLabel);
        panel.add(dobField);
        panel.add(addButton);
        panel.add(displayButton);
        panel.add(sortButton);
        panel.add(searchButton);
        panel.add(modifyButton);

        // Add panel to frame
        this.add(panel);
        this.pack();
        this.setVisible(true);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Establish database connection
        try {
            dbConnect db = new dbConnect();
            conn = db.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, "Database connection failed.");
        }
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == addButton) {
            // Insert new student into the database
            String sql = "INSERT INTO students (student_id, first_name, last_name, major, phone, gpa, date_of_birth) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            try {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, studentIdField.getText());
                pstmt.setString(2, firstNameField.getText());
                pstmt.setString(3, lastNameField.getText());
                pstmt.setString(4, majorField.getText());
                pstmt.setString(5, phoneField.getText());
                pstmt.setString(6, gpaField.getText());
                pstmt.setString(7, dobField.getText());
                pstmt.executeUpdate();
                JOptionPane.showMessageDialog(null, "Student added successfully.");
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null, "Error adding student.");
            }
        } else if (e.getSource() == displayButton) {
            // Display all students in the database
            String sql = "SELECT * FROM students";
            try {
                pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();

                // Assuming Table has a buildTableModel(ResultSet rs) method
                Table tb = new Table();
                JTable table = new JTable(tb.buildTableModel(rs));
                JOptionPane.showMessageDialog(null, new JScrollPane(table));
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null, "Error displaying students.");
            }
        } else if (e.getSource() == sortButton) {
            // Sort students by selected column
            String[] options = {"First Name", "Last Name", "Major"};
            int choice = JOptionPane.showOptionDialog(null, "Sort by:", "Sort", JOptionPane.DEFAULT_OPTION,
                    JOptionPane.PLAIN_MESSAGE, null, options, options[0]);

            String column;
            switch (choice) {
                case 0:
                    column = "first_name";
                    break;
                case 1:
                    column = "last_name";
                    break;
                case 2:
                    column = "major";
                    break;
                default:
                    column = "";
                    break;
            }

            String sql = "SELECT * FROM students ORDER BY " + column;
            try {
                pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();

                Table tb = new Table();
                JTable table = new JTable(tb.buildTableModel(rs));
                JOptionPane.showMessageDialog(null, new JScrollPane(table));
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null, "Error sorting students.");
            }
        } else if (e.getSource() == searchButton) {
            // Search for a student by selected column
            String[] options = {"Student ID", "Last Name", "Major"};
            int choice = JOptionPane.showOptionDialog(null, "Search by:", "Search", JOptionPane.DEFAULT_OPTION,
                    JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
            String column;
            switch (choice) {
                case 0:
                    column = "student_id";
                    break;
                case 1:
                    column = "last_name";
                    break;
                case 2:
                    column = "major";
                    break;
                default:
                    column = "";
                    break;
            }
            String searchTerm = JOptionPane.showInputDialog("Enter search term:");
            String sql = "SELECT * FROM students WHERE " + column + " LIKE ?";
            try {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%" + searchTerm + "%");
                ResultSet rs = pstmt.executeQuery();

                Table tb = new Table();
                JTable table = new JTable(tb.buildTableModel(rs));
                JOptionPane.showMessageDialog(null, new JScrollPane(table));
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null, "Error searching students.");
            }
        } else if (e.getSource() == modifyButton) {
            // Modify a student's data
            String studentId = JOptionPane.showInputDialog("Enter student ID:");
            String sql = "SELECT * FROM students WHERE student_id = ?";
            try {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, studentId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String[] options = {"First Name", "Last Name", "Major", "Phone", "GPA", "Date of Birth"};
                    int choice = JOptionPane.showOptionDialog(null, "Select field to modify:", "Modify",
                            JOptionPane.DEFAULT_OPTION, JOptionPane.PLAIN_MESSAGE, null, options, options[0]);

                    String column;
                    switch (choice) {
                        case 0:
                            column = "first_name";
                            break;
                        case 1:
                            column = "last_name";
                            break;
                        case 2:
                            column = "major";
                            break;
                        case 3:
                            column = "phone";
                            break;
                        case 4:
                            column = "gpa";
                            break;
                        case 5:
                            column = "date_of_birth";
                            break;
                        default:
                            column = "";
                            break;
                    }

                    String newValue = JOptionPane.showInputDialog("Enter new value:");
                    sql = "UPDATE students SET " + column + " = ? WHERE student_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, newValue);
                    pstmt.setString(2, studentId);
                    pstmt.executeUpdate();
                    JOptionPane.showMessageDialog(null, "Student data updated successfully.");
                } else {
                    JOptionPane.showMessageDialog(null, "Student not found.");
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null, "Error modifying student data.");
            }
        }
    }

    public static void main(String[] args) {
        new AppGUI();
    }
}