<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String name="홍길동";
	//request에 저장
	//request.setAttribute("name",name);
%>
<c:set var="name" value="심청이"/>
<%-- EL에서 출력이 가능하게 변수를 설정한다 --%>
<%-- <c:set 은 request.setAttribute()가 아니다! --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>자바출력</h1>
  이름1 : <%=name %><br>
  이름2 : <%=request.getAttribute("name") %>
  <h1>EL</h1>
  이름3 : ${name }<%--= 같음 = <%=request.getAttribute("name") %>  --%>
  <br>
  <%-- c:out은 jquery와의 충돌을 방지하기위한 형식! / 많이 사용하지 않는다 
  	출력형식 => $
  	VueJS => {{}}
  	React => {}
  --%>
  이름4 : <c:out value="${name }"/><br>
  이름5 : <c:out value="<%=name %>"/>
  <%-- JS에서 JSTL사용이 가능 --%>
</body>
</html>