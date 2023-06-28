<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%-- 연습 --%>
 <%-- import --%>
 <%-- 제어문, URL, 변수선언 --%>
 <%--prefix => 사용자가 결정 가능--%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%-- format --%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%-- function : fn --%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	// 데이터 설정 => 오라클
	List<String> names=new ArrayList<String>();
	names.add("홍길동");
	names.add("심청이");
	names.add("이순신");
	names.add("박문수");
	names.add("강감찬");
	// 일반 변수이므로 EL은 사용할 수 없다(EL ${} => request,session에 저장을 해야 사용 가능)
	request.setAttribute("names", names);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>자바를 이용한 for문</h1>
  <h3>이름 목록</h3>
  <ul>
  <%
	for(String name:names){
	%>
		<li><%= name %></li>
	<%
	}
  %>
  </ul>
  <h3>JSTL출력</h3>
  <ul>
    <c:forEach var="name" items="${names }">
      <ul>
        <li>${name }</li>
      </ul>
    </c:forEach>
  </ul>
  <h3>자바 (StringTokenizer)</h3>
  <ul>
	<%
	  String color="red,blue,green,yellow,black";
	  StringTokenizer st=new StringTokenizer(color,",");
	  while(st.hasMoreTokens()){
	%>
		<li><%=st.nextToken() %></li>
	<%
	  }
	  	
	%>
  </ul>
  <h3>JSTL (forTokens)</h3>
  <ul>
<%--<c:forTokens
    var="color" : st.nextTokens()
    items="red,blue,green,yellow,black"
    delims="," : 구분자
    >

      <li>${color }</li>
    </c:forTokens> --%>
  </ul>
</body>
</html>