<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>  
<%
	request.setCharacterEncoding("euc-kr");

	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String id = "scott";
	String pass = "tiger";
	String no = request.getParameter("no");
	String writer = request.getParameter("writer");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String regdate = request.getParameter("regdate");
	String password = request.getParameter("password");
	
	try {	
		Connection conn = DriverManager.getConnection(url,id,pass);
		
		String sql = "INSERT INTO t2(no,title,writer,content, password ,regdate) VALUES(t_c.nextval,?,?,?,?,sysdate)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		

		pstmt.setString(1,title);
		pstmt.setString(2,writer);
		pstmt.setString(3,content);
		pstmt.setString(4,password);
		
		pstmt.execute();
		pstmt.close();
		
		conn.close();
} catch(SQLException e) {
	out.println( e.toString() );
	}
%>
<script>
alert("등록이 되었습니다");
location.href="board.jsp";
</script>