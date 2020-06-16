<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	Connection connection = null;
	Statement statement = null;
	ResultSet resultset = null;
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String uid = "scott";
	String upw = "tiger";
	String query = "select no, title, writer, to_char(regdate, 'yyyy-mm-dd') as regdate from t2";
%>
<!DOCTYPE>
<html>
<head>
 <link href="index.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>hey you</title>
</head>
<body>

<ul>
	<li><a href="index.jsp">NBA <strong>EAST</strong></a></li>
    <li><a href="index2.jsp">NBA <strong>WEST</strong></a></li>
	<li><a class="active" href="board.jsp">자유 게시판</a></li>
</ul>

<h1>느바갤러리</h1>
<table class="board" align ="left">
	<tr id="head" align="center" >
		<th>번호</th>
		<th>제목</th>
		<th>글쓴이</th>
		<th>작성일</th>
 	</tr>
 	
<% 
	try{
	Class.forName(driver);
	connection = DriverManager.getConnection(url,uid,upw);
	statement = connection.createStatement();
	resultset = statement.executeQuery(query);
	while(resultset.next()){
		String no = resultset.getString("no");
		String title = resultset.getString("title");
		String writer = resultset.getString("writer");
		String wDate = resultset.getString("regdate");
%>
	<tr class = "cont" align = center>
		<td><%=no%></td>
		<td><a href="view.jsp?no=<%=no%>"><%=title%></a></td>
		<td><%=writer%></td>
		<td><%=wDate%></td>
	</tr>
<%
	}
%>
	</table>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		try{
			if(resultset !=null) resultset.close();
			if(statement !=null) resultset.close();
			if(connection !=null) resultset.close();
		}catch(Exception e2){
			e2.printStackTrace();
		}
	}
%>
 <input type = "button" name ="write" value = "글쓰기" onclick ="window.location='write.jsp'">
</body>
</html>

















