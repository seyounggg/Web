<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	EL 지원하는 내장객체(581page)
	★	1) requestScope => request.setAttribute()
	★	2) sessionScope => session.setAttribute()
		3) param		=> request.getParmeter()
		4) paramValues	=> request.getParameterValues()
--%>
<%
	String name="홍길동";
	request.setAttribute("name","홍길동");
	session.setAttribute("name","심청이");
	// 중복되는 경우에 우선순위는 request!
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
이름:${name },${requestScope.name }
<%-- requestScope. 생략 가능 --%>
<%=request.getAttribute("name") %>
<%-- 변수명이 아니라 설정된 key값을 출력 --%>
</body>
</html>