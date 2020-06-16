<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html> 
<head> 
	<title>hey you</title> 
</head> 
<body> 
	<table> 
		<form name=writeform method=post action="write_ok.jsp"> 
			<tr> 
				<td> 
					<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
					  <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;"> 
					  <td width="5"><img src="img/table_left.gif" width="5" height="30" /></td> 
					  <td>글쓰기</td> 
					  <td width="5"> <img src="img/table_right.gif" width="5" height="30" /> </td> 
					  </tr> 
					  </table> 
					 <table> 
					   <tr> 
					   	<td>&nbsp;</td> 
					   	<td align="center">제목</td> 
					   	<td><input name="title" size="50" maxlength="100"></td> 
					   	<td>&nbsp;</td> 
					   </tr> 
					   <tr height="1" bgcolor="#dddddd">
					   	<td colspan="4"></td>
					   </tr>
					   <tr> 
					    <td>&nbsp;</td> 
					     <td align="center">이름</td> 
					     <td><input name="writer" size="50" maxlength="50"></td> 
					     <td>&nbsp;</td> 
					     </tr>
					      <tr height="1" bgcolor="#dddddd">
					      <td colspan="4"></td>
					      </tr>
					      <tr>
                           <td>&nbsp;</td>
                           <td align="center">비밀번호</td>
                           <td><input type="password" name="password" size="50" maxlength="50"></td>
   						   <td>&nbsp;</td>
     					  </tr> 
					      <tr height="1" bgcolor="#dddddd">
					      <td colspan="4"></td>
					      </tr> 
					      <tr> 
					      <td>&nbsp;</td> 
					     <td align="center">내용</td>
					      <td><textarea name="content" cols="50" rows="13"></textarea></td>
					       <td>&nbsp;</td> 
					       </tr> 
					       <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
					        <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr> 
					        <tr align="center"> 
					        <td>&nbsp;</td> 
					        <td colspan="2">
					     <input type=submit value="등록"> 
					     <input type=button value="취소" OnClick="window.location='board.jsp'"> 
					     <td>&nbsp;</td> 
					    	 </tr>
					    </table>  
					</td> 
				</tr> 
			</form> 
		</table> 
	</body> 
</html>

