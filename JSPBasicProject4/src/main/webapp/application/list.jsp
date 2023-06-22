<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String fn=request.getParameter("fn");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <img src="../image/<%=fn %>" style="width:100%">
  <!-- 이 jsp파일은 application폴더에 들어가 있으니까 -> ../ 밖에 있는 image폴더로 변경 -->
</body>
</html>