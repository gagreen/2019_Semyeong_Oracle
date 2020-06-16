
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import = "java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
	String query = "SELECT * FROM nba_west_rank ORDER BY rank";
%>
<!DOCTYPE html>
<html>
<head>
	<link href="index.css" rel="stylesheet" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>NBA 순위/게시판</title>
</head>
<body>


 <ul>
      <li><a  href="index.jsp">NBA <strong>EAST</strong></a></li>
      <li><a class="active" href="index2.jsp">NBA <strong>WEST</strong></a></li>
      <li><a href="board.jsp">자유 게시판</a></li>
    </ul>

<h1>서부 컨퍼러스 팀 순위</h1>
<table class="board" align ="left">
	<tr id="head" align="center" >
		<th>순위</th>
		<th>팀</th>
		<th>디비전</th>
		<th>경기수</th>
		<th>승</th>
		<th>패</th>
		<th>승률</th>
		<th>승차</th>
		<th>홈승</th>
		<th>홈패</th>
		<th>원정승</th>
		<th>원정패</th>
		<th>디비전승</th>
		<th>디비전패</th>
		<th>연속</th>
	</tr>
<% 
	try{
	Class.forName(driver);
	connection = DriverManager.getConnection(url,uid,upw);
	statement = connection.createStatement();
	resultset = statement.executeQuery(query);
	while(resultset.next()){
		String rank = resultset.getString("rank");
		String team = resultset.getString("team");
		String division = resultset.getString("division");
		String games = resultset.getString("games");
		String win = resultset.getString("win");
		String lose = resultset.getString("lose");
		String pct = resultset.getString("pct");
		String dif = resultset.getString("dif");
		String hWin = resultset.getString("hWin");
		String hLose = resultset.getString("hLose");
		String aWin = resultset.getString("aWin");
		String aLose= resultset.getString("aLose");
		String dWin = resultset.getString("dWin");
		String dLose = resultset.getString("dLose");
		String streak = resultset.getString("streak");
		
%>
	<tr class="rank" align = center>
		<td class = "point"><%=rank%></td>
		<td class = "point"><%=team%></td>
		<td><%=division %></td>
		<td><%=games %></td>
		<td><%=win %></td>
		<td><%=lose %></td>
		<td><%=pct %></td>
		<td><%=dif %></td>
		<td><%=hWin %></td>
		<td><%=hLose %></td>
		<td><%=aWin %></td>
		<td><%=aLose %></td>
		<td><%=dWin %></td>
		<td><%=dLose %></td>
		<td><%=streak %></td>
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
</body>
</html>

















