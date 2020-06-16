package updateData;

import java.io.IOException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.sql.*;
import java.util.*;
 
public class dbExcute {
	
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "scott";
	private String password = "tiger";
	
	
	public Connection getConnection() { //db 연결
        Connection conn = null;
        try {
            Class.forName(driver);
            try {
            	conn = DriverManager.getConnection(url, user, password);
            	System.out.println("연결 성공");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return conn;
 
    }
	
	public void closeAll(Connection conn, PreparedStatement pstmt, ResultSet rs) { // db 연결 해제
        try { 
            if (rs != null)
                rs.close();// 유효성검사 후 자원 반납
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        } catch (SQLException e) {
            System.out.println("DB close");
            e.printStackTrace();
        }
 
    }
	
    public void dbDelete() { // db 내용 삭제
    	Connection conn = this.getConnection();
    	PreparedStatement pstmt = null;
        
		String query1 = "DELETE FROM nba_east_rank";
		String query2 = "DELETE FROM nba_west_rank";
        try {   
            pstmt = conn.prepareStatement(query1);
            
            if(pstmt.executeUpdate() == 1) {
            	System.out.println("동부 삭제 성공");
            }else {
            	System.out.println("동부 삭제 실패");
            }
            pstmt = conn.prepareStatement(query2);
            
            if(pstmt.executeUpdate() == 1) {
            	System.out.println("동부 삭제 성공");
            }else {
            	System.out.println("동부 삭제 실패");
            }
            
        } catch (SQLException sqle) {
            System.out.println("DB 접속실패 : "+sqle.toString());
        } catch (Exception e) {
            System.out.println("Unkonwn error");
            e.printStackTrace();
        }
        
        return;
        
    }
	
    public void dbInsertEast(Iterator<Element> ieE) {
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	String query = "INSERT INTO nba_east_rank VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    	
    	conn = this.getConnection();
    	
    	try {
    		pstmt = conn.prepareStatement(query);
    		while(ieE.hasNext()){
    			pstmt.setString(1, ieE.next().text());
    			pstmt.setString(2, ieE.next().text());
    			pstmt.setString(3, ieE.next().text());
    			pstmt.setString(4, ieE.next().text());
    			pstmt.setString(5, ieE.next().text());
    			pstmt.setString(6, ieE.next().text());
    			pstmt.setString(7, ieE.next().text());
    			pstmt.setString(8, ieE.next().text());
    			pstmt.setString(9, ieE.next().text());
    			pstmt.setString(10, ieE.next().text());
    			pstmt.setString(11, ieE.next().text());
    			pstmt.setString(12, ieE.next().text());
    			pstmt.setString(13, ieE.next().text());
    			pstmt.setString(14, ieE.next().text());
    			pstmt.setString(15, ieE.next().text());    			
    			
    			if(pstmt.executeUpdate() == 1) {
    				System.out.println("삽입 성공");
    			} else {
    				System.out.println("삽입 실패");
    			}
    		}
    		
    	} catch (SQLException e) {
            e.printStackTrace();
        } finally {
 
            this.closeAll(conn, pstmt, null);
        }
    }
    public void dbInsertWest(Iterator<Element> ieW) {
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	String query = "INSERT INTO nba_west_rank VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    	
    	conn = this.getConnection();
    	
    	try {
    		pstmt = conn.prepareStatement(query);
    		while(ieW.hasNext()){
    			pstmt.setString(1, ieW.next().text());
    			pstmt.setString(2, ieW.next().text());
    			pstmt.setString(3, ieW.next().text());
    			pstmt.setString(4, ieW.next().text());
    			pstmt.setString(5, ieW.next().text());
    			pstmt.setString(6, ieW.next().text());
    			pstmt.setString(7, ieW.next().text());
    			pstmt.setString(8, ieW.next().text());
    			pstmt.setString(9, ieW.next().text());
    			pstmt.setString(10, ieW.next().text());
    			pstmt.setString(11, ieW.next().text());
    			pstmt.setString(12, ieW.next().text());
    			pstmt.setString(13, ieW.next().text());
    			pstmt.setString(14, ieW.next().text());
    			pstmt.setString(15, ieW.next().text());    			
    			
    			if(pstmt.executeUpdate() == 1) {
    				System.out.println("삽입 성공");
    			} else {
    				System.out.println("삽입 실패");
    			}
    		}
    		
    	} catch (SQLException e) {
            e.printStackTrace();
        } finally {
 
            this.closeAll(conn, pstmt, null);
        }
    }
	
    public Iterator<Element> crawling(String url) {
         Document doc = null;
         
         // Jsoup을 이용한 웹 크롤링
         try {
             doc = Jsoup.connect(url).get();
         } catch (IOException e) {
             e.printStackTrace();
         }
         
         Elements element = doc.select("tbody#regularTeamRecordList_table");
         
         return element.select("span, strong").iterator();
    }
    
    public void excute() {
    	
        Iterator<Element> ieE = this.crawling("https://sports.news.naver.com/basketball/record/index.nhn?category=nba&year=2020&conference=EAST");
        Iterator<Element> ieW = this.crawling("https://sports.news.naver.com/basketball/record/index.nhn?category=nba&year=2020&conference=WEST");
        
        
        
		
        this.dbDelete();
        this.dbInsertEast(ieE);
        this.dbInsertWest(ieW);
        
    }
 
}