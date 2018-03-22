package neu.edu;

import java.net.ConnectException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	
	private static final String URL = "jdbc:mysql://localhost:3306/joshuafeng";
	private static final String USER = "root";
	private static final String PASSWORD = "123456";

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		
		
		
		
		//1.load driver
		Class.forName("com.mysql.jdbc.Driver");
		//2.get database connection
		Connection conn = DriverManager.getConnection(URL,USER,PASSWORD);
		//3.munipulate db
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select web_url,snippet from article");
		
		while(rs.next()) {
			System.out.println(rs.getInt("web_url"));
			System.out.println(rs.getString("snippet"));
			
		}
		
		
	}
}
