<%--
	JSP안에서의 조건문
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	int sum=0;
	int even=0;
	int odd=0;
%>
<%--
	<%! %> : X => 보통 자바에서 코딩하고, 메소드를 불러오는 형식이므로
				선언부에서 메소드를 만들거나 하지는 않음. 거의 사용하지 않음.
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <%
  	for(int i=1;i<=100;i++){
  		if(i%2==0)
  			even+=i;
  		else
  			odd+=i;
  		sum+=i;
  	}
  %>
  <h1>1~100까지의 총 합:<%=sum %></h1>
  <h1>1~100까지의 짝수 합:<%=even %></h1>
  <h1>1~100까지의 홀수 합:<%=odd %></h1>
</body>
</html>