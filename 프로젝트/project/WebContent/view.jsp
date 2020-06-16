<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<% 
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String id = "scott";
	String pass = "tiger";
	int no = Integer.parseInt(request.getParameter("no")); 
	try 
	{
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		String sql = "SELECT writer, title, content, regdate FROM t2 WHERE no=" + no;
		ResultSet rs = stmt.executeQuery(sql); 
		if(rs.next()){ 
			String writer = rs.getString(1);
			String title = rs.getString(2);
			String content = rs.getString(3);
			String regdate = rs.getString(4); 
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <html> 
 <head> 
 <title>게시판</title>
  </head> 
  <body>
   <table>
    <tr>
     <td>
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
       <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
        <td width="5"><img src="img/table_left.gif" width="5" height="30" />
        </td> 
        <td>내 용</td>
         <td width="5"><img src="img/table_right.gif" width="5" height="30" /></td> </tr> </table> <table width="413"> <tr> <td width="0">&nbsp;</td> <td align="center" width="76">글번호</td>
          <td width="319"><%=no%></td> 
          <td width="0">&nbsp;</td>
           </tr> 
           <tr height="1" bgcolor="#dddddd">
           <td colspan="4" width="407"></td>
           </tr>
            <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407">
            </td>
            </tr> 
            <tr>
             <td width="0">&nbsp;</td>
             <td align="center" width="76">이름</td> 
             <td width="319"><%=writer%></td> 
             <td width="0">&nbsp;</td> 
             </tr> 
             <tr height="1" bgcolor="#dddddd">
             <td colspan="4" width="407">
             </td>
             </tr> 
             <tr>
              <td width="0">&nbsp;</td> 
              <td align="center" width="76">작성일</td> 
              <td width="319"><%=regdate%></td> 
              <td width="0">&nbsp;</td> 
             </tr> 
             <tr height="1" bgcolor="#dddddd">
             <td colspan="4" width="407"></td>
             </tr>
              <tr> 
               <td width="0">&nbsp;</td>
               <td align="center" width="76">제목</td>
               <td width="319"><%=title%></td> 
               <td width="0">&nbsp;</td> 
              </tr> 
              <tr height="1" bgcolor="#dddddd">
               <td colspan="4" width="407"></td>
              </tr> 
              <tr> 
               <td width="0"></td> 
               <td width="399" colspan="2" height="200"><%= content %> </td>
               </tr>
 <%           
 				stmt.executeUpdate(sql); 
 				rs.close(); 
 				stmt.close(); 
 				conn.close(); 
 				} 
		}catch(SQLException e) { }
                
           %>
                <tr height="1" bgcolor="#dddddd">
                <td colspan="4" width="407"></td>
                </tr> <tr height="1" bgcolor="#82B5DF">
                <td colspan="4" width="407"></td>
                </tr>
                <tr align="center"> 
                 <td width="0">&nbsp;</td> 
                 <td colspan="2" width="399">
                 <input type=button value="글쓰기" OnClick="window.location='write.jsp'">
                 <input type=button value="목록" OnClick="window.location='board.jsp'">
                 <input type=button value="삭제" OnClick="window.location='delete.jsp?no=<%=no%>'">
                  <td width="0">&nbsp;</td> 
                 </tr> 
                </table> 
               </td>
              </tr> 
             </table> 
            </body>
</html>