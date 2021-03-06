package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import post.Post;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
			String dbID = "chan";
			String dbPassword = "1111";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	} 
	
	public int login(String ID, String PASSWORD) {
		String SQL = "SELECT PASSWORD FROM ACCOUNT WHERE EMAIL = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, ID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(PASSWORD))
					return 1;
				else
					return 0;
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int register(User user) {
		String SQL = "INSERT INTO ACCOUNT VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getPASSWORD());
			pstmt.setString(2, user.getNICKNAME());
			pstmt.setString(3, user.getEMAIL());
			pstmt.setString(4, user.getADDRESS());
			pstmt.setString(5, user.getPHONE_NUM());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public User getUserInfo(String userEmail) {
		String SQL = "SELECT * FROM ACCOUNT WHERE EMAIL = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setEMAIL(rs.getString(3));
				user.setPASSWORD(rs.getString(1));
				user.setPHONE_NUM(rs.getString(5));
				user.setNICKNAME(rs.getString(2));
				user.setADDRESS(rs.getString(4));
				return user;
			}		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int reviseUserInfo(User user) {
		String SQL = "UPDATE ACCOUNT SET PASSWORD = ?, NICKNAME = ?, ADDRESS = ?, PHONE_NUM = ? WHERE EMAIL = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getPASSWORD());
			pstmt.setString(2, user.getNICKNAME());
			pstmt.setString(3, user.getADDRESS());
			pstmt.setString(4, user.getPHONE_NUM());
			pstmt.setString(5, user.getEMAIL());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
	return -1;
	}
	
}
