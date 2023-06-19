<%-- 149page
	import=> 라이브러리 가져오기
	<%@ import="java.util.*, java.io.*" %> -> 여러개 한번에 첨부!!
	<%@ page import="java.sql.*" %> -> 한개씩도 가능
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.text.*" buffer="16kb"%>
<%@ page import="com.sist.*" %>
<%
	Date date=new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy년 MM월 dd일");
	String today=sdf.format(date);
	MainClass m=new MainClass();
	String msg=m.display();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	오늘 날짜는 <%=today %>
	<h1><%=msg %></h1>
	<h1>총버퍼:<%= out.getBufferSize() %></h1>
	<h1>남은버퍼:<%= out.getRemaining() %></h1>
	<h1>사용중 버퍼:<%= out.getBufferSize()-out.getBufferSize() %></h1>
</body>
</html>