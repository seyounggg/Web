<%--
	<%! %> : 선언문 => 메소드 선언 => 클래스로 변경되면 클래스 블록 안으로!!
			public class className{
				여기에 선언됨!
			}
	<% %> / <%= %>
	=> public void _jspServlet(){
		--------------------
		<% %>
		<%= %> : out.println( 여기에 ) 
		--------------------	
	}
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public int add(int a, int b){
	return a+b;
	}
%>
<%
	int a=10;
	int b=20;
	int c=add(a,b);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>결과:<%= c %></center>
</body>
</html>