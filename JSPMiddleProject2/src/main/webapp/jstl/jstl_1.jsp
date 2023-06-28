<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
		JSTL (598page) : 태그로 자바 문법을 만든 태그 라이브러리
			- core : 자바 제어문, URL관랸, 화면이동, 변수 설정(request.setAttribute())
				조건문
					<c:if text="조건문">
						조건문이 true일 때 실행
					</c:if>
					=> 다중 if, if~else가 없다
				선택문
					<c:choose>
					  <c:when test="">처리문장</c:when>
					  <c:when test="">처리문장</c:when>
					  <c:when test="">처리문장</c:when>
					  <c:otherwise>default</c:otherwise> => else/default
					</c:choose>
					=> switch , 다중 if
				반복문
					일반 for
						for(int i=0;i<=10;i++)
							↓
						<c:forEach var="i" begin="0" end="10" step="1">
							반복 수행 문장
						</c:forEach>
						** 단점 **
						for(int i=10;i>=0;i--)
							=> 이건 <c:forEach>가 없다!! 무조건 i++만 가능!
				★★★	for - each (=> 향상된 for)
						for(boardVO vo:list)
							↓
						<c:forEach var="vo" items="list"> => 가장 많이 사용
						</c:forEach>
					<c:forTodens> => StringTokenizer
				
				response.sendRedirect(url) => URL : 화면이동
					=> <:redircet url="url">
				request.setAttribute("a",값)
					=> <c:set var="a" value="값">
				out.println()
					=> <c:out value="">
					=> 자바스크립트에서 자바데이터를 받아서 출력할 때 <c:out value="">를 써야한다
						이유: jquery => $사용!! EL 형식도 ${ } => jquery로 인식하므로 <c:out 을 사용해야한다.
			
			- fmt : 변환
				SimpleDateFormat : 날짜변환
					|
				<fmt:formatDate value="" pattern="yyyy-MM-dd">
				DecimalFormat : 숫자변환
					|
				<fmt:formatNumber value="" pattern="999,999">
			- fn : String 클래스의 메소드 이용
				${fn:length(문자열)}
				${fn:subString(문자열, start, end)}
			----------------------------------------------------------------------
			- sql : DAO
			- xml : OXM
				=> 자바자체에서 처리(사용 빈도가 거의 없다)
			----------------------------------------------------------------------
 --%>
<%-- import --%>
<%-- 제어문, URL, 변수선언 --%>
<%--prefix => 사용자가 결정 가능--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- format --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- function : fn --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>자바</h1>
  <%
  	for(int i=1;i<=10;i++){
  %>
  		<%=i %>&nbsp;
  <%
  	}
  %>
  <h1>JSTL</h1>
  <c:forEach var="i" begin="1" end="10" step="1">
    ${i }&nbsp;
  </c:forEach>
</body>
</html>