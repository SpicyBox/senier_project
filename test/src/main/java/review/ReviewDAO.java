package review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import post.Post;
import user.User;

public class ReviewDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ReviewDAO() {
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
	
	public ArrayList<Review> getReview(int postID){
		String SQL = "SELECT * FROM REVIEW";
		ArrayList<Review> list = new ArrayList<Review>();
		try {
            SQL +=" WHERE POST_NUM LIKE '%" + postID + "%'";
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Review review = new Review();
				review.setSCORE(rs.getString(1));
				review.setPOSTING_DATE(rs.getString(2));
				review.setREVIEW_CONTENTS(rs.getString(3));
				review.setNICKNAME(rs.getString(4));
				review.setEMAIL(rs.getString(6));
				list.add(review);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int reviewWirte(Review review) {
		String SQL = "INSERT INTO REVIEW VALUES (?, SYSDATE, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, review.getSCORE());
			pstmt.setString(2, review.getREVIEW_CONTENTS());
			pstmt.setString(3, review.getNICKNAME());
			pstmt.setString(4, review.getPOST_NUM());
			pstmt.setString(5, review.getEMAIL());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public void reviewAvgUpdate(Review review) {
		String SQL = "UPDATE POST SET score = (select AVG(SCORE) FROM review WHERE post_num = ?) WHERE post_num = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, review.getPOST_NUM());
			pstmt.setString(2, review.getPOST_NUM());
			pstmt.executeQuery();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}