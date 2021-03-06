package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.User;

public class PostDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public PostDAO() {
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
	
	public int posting(Post post) {
		String SQL = "INSERT INTO POST VALUES (?, ?, SYSDATE, ?, 0, POST_SEQ1.NEXTVAL, ?, ?, ?, 0, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, post.getTITLE());
			pstmt.setString(2, post.getPOST_CONTENTS());
			pstmt.setString(3, post.getPRICE());
			pstmt.setString(4, post.getID());
			pstmt.setString(5, post.getADDRESS());
			pstmt.setString(6, post.getINFO());
			pstmt.setString(7, post.getRENTAL_TIME());
			pstmt.setString(8, post.getPHOTO());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int postRevise(Post post) {
		String SQL = "UPDATE POST SET TITLE = ?, POST_CONTENTS = ?, PRICE = ?, ADDRESS = ?, INFO = ?, RENTAL_TIME = ?, PHOTO = ? WHERE POST_NUM = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, post.getTITLE());
			pstmt.setString(2, post.getPOST_CONTENTS());
			pstmt.setString(3, post.getPRICE());
			pstmt.setString(4, post.getADDRESS());
			pstmt.setString(5, post.getINFO());
			pstmt.setString(6, post.getRENTAL_TIME());
			pstmt.setString(7, post.getPHOTO());
			pstmt.setString(8, post.getPOST_NUM());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Post> getSearch(String type, String searchText){
		String SQL = "SELECT * FROM POST";
		ArrayList<Post> list = new ArrayList<Post>();
		try {
			if(searchText != null && !searchText.equals("") ){
                SQL +=" WHERE " + type + " LIKE '%" + searchText.trim() + "%'";
            }
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Post post = new Post();
				post.setTITLE(rs.getString(1));
				post.setPOST_DATE(rs.getString(3));
				post.setPRICE(rs.getString(4));
				post.setVIEW_COUNT(rs.getString(5));
				post.setPOST_NUM(rs.getString(6));
				post.setID(rs.getString(7));
				post.setADDRESS(rs.getString(8));
				post.setINFO(rs.getString(9));
				post.setSCORE(rs.getDouble(10));
				post.setRENTAL_TIME(rs.getString(11));
				post.setPHOTO(rs.getString(12));
				list.add(post);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public void viewCountUp(int postID) {
		String SQL = "Update POST SET view_count = post.view_count + 1 WHERE post_num = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Post getPostDetail(int postID) {
		String SQL = "SELECT * FROM POST WHERE POST_NUM = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Post post = new Post();
				post.setTITLE(rs.getString(1));
				post.setPOST_CONTENTS(rs.getString(2));
				post.setPOST_DATE(rs.getString(3));
				post.setPRICE(rs.getString(4));
				post.setVIEW_COUNT(rs.getString(5));
				post.setPOST_NUM(rs.getString(6));
				post.setID(rs.getString(7));
				post.setADDRESS(rs.getString(8));
				post.setINFO(rs.getString(9));
				post.setSCORE(rs.getDouble(10));
				post.setRENTAL_TIME(rs.getString(11));
				post.setPHOTO(rs.getString(12));
				return post;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int postDelete(int postID) {
		String SQL = "DELETE FROM POST WHERE POST_NUM = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			rs = pstmt.executeQuery();
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
	return -1;
	}
} 
