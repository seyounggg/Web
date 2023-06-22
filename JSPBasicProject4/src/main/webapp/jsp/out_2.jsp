<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <%를 계속 열고 닫고 해야한다면
	out.println() 사용하는게 더 편한다 --%>
  <%
  	for(int i=1;i<=10;i++){
  		if(i%2==0){
  			out.println(i+"&nbsp;");
  		}
  	}
  %>
</body>
</html>