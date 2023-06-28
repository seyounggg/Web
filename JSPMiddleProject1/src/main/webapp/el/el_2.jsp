<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	EL 지원하는 내장객체(581page)
		★	1) requestScope => 기존의 request + 추가 데이터 설정
				request.setAttribute("key","값") : 오라클에서 얻은 값을 추가
				request.getAttribute("key")
					|
				${requestScope.key} => ${key} => 출력형식!
		★	2) sessionScope => session에 저장된 값 읽기
				session.setAttribute()
				${sessionScope.key} => ${key} => 우선순위: request > session
			3) param
				request.getParmeter("key")
				${param.key}
			4) paramValues
				request.getParameterValues()
				${paramValues.key}
		★★★ ${자바의 일반 변수 사용이 안된다}
			String name="";
			${name} => 출력 안됨
			request.setAttribute("name",""}
				|
				${name}
			session.setAttribute("name",""}
				|
				${name}
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