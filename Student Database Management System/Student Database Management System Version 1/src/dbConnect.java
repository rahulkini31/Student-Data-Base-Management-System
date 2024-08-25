import java.sql.*;

public class dbConnect {
    private static Connection mycon=null;

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        String user = "root", pass ="acugesict"; // root password
        String url = "jdbc:mysql://localhost:3306/studentdata";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url,user,pass);
        return conn;
    }
}
// root@localhost:3306