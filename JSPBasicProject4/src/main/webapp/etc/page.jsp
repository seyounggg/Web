<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %><!-- info="page" -->
<%!
	String msg="Hello JSP"; // 멤버변수
	public String display(){ // 메소드
		return msg; 
	}
	/*
		public class page_jsp extends HttpServlet{
			String msg="Hello JSP"; // 멤버변수
			public String display(){ // 메소드
				return msg; 
			}
			public void _jspService(){
				
				--------------------
				this.msg //(원래는 this. 다 작성해야하는데 우리가 생략하고 있었던것!!)
				--------------------
			}
		}
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <%
	String msg="Hello JSP(지역변수)";
  	String pageInfo=this.getServletInfo();
  %>
  <%=this.msg %><br>
<%--   pageInfo : <%=pageInfo %> --%>
</body>
</html>