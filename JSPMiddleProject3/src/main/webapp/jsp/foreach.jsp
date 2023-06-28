<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	List<String> list=new ArrayList<String>();
	list.add("red");
	list.add("blue");
	list.add("green");
	list.add("yellow");
	list.add("purple");
%>
<c:set var="list" value="<%=list %>"/>
<%--
	JSTL에서 제공하는 태그는 XML로 만들어져 있다
	1. 태그, 속성은 대소문자를 구분한다
	2. 속성값은 반드시 "" 를 사용해야한다
	3. 여는 태그 / 닫는 태그를 반드시 사용한다
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>Java</h1>
  <ul>
    <li><%=list.get(0) %></li>
    <li><%=list.get(1) %></li>
    <li><%=list.get(2) %></li>
    <li><%=list.get(3) %></li>
    <li><%=list.get(4) %></li>
  </ul>
  <h1>Java - for</h1>
  <ul>
    <%
    	for(int i=0;i<list.size();i++){
    %>
    	<li><%=list.get(i) %></li>
    <%	
    	}
    %>
  </ul>
  <h1>Java - forEach</h1>
  <ul>
    <%
    	for(String color:list){
    %>
    	<li><%=color %></li>
    <%
    }
    %>
  </ul>
  <h1>EL</h1>
  <ul>
    <li>${list[0] }</li>
    <li>${list[1] }</li>
    <li>${list[2] }</li>
    <li>${list[3] }</li>
    <li>${list[4] }</li>
  </ul>
  <h1>JSTL</h1>
  <ul>
    <c:forEach var="color" items="${list }">
      <li>${color }</li>
    </c:forEach>
  </ul>
  <h1>JSTL2</h1>
  <ul>
    <%-- varStatus : List의 인덱스 번호를 읽어온다 --%>
    <c:forEach var="color" items="${list }" varStatus="s">
      <%-- <li>${s.index+1 }.s{color}</li> --%>
      <li>${list[s.index] }</li>
    </c:forEach>
  </ul>
  <h1>JSTL3</h1>
  <%
  	List<String> names=new ArrayList<String>();
  	names.add("hong");
  	names.add("shim");
  	names.add("park");
  	names.add("chun");
  	names.add("kang");
  	
  	List<String> sexs=new ArrayList<String>();
  	sexs.add("남");
  	sexs.add("여");
  	sexs.add("남");
  	sexs.add("여");
  	sexs.add("남");
  %>
  <c:set var="names" value="<%=names %>"/>
  <c:set var="sexs" value="<%=sexs %>"/>
  <ul>
    <c:forEach var="name" items="${names }" varStatus="s">
      <li>${name }(${sexs[s.index]})</li>
    </c:forEach>
  </ul>
</body>
</html>