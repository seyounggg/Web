<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  메소드 방식: <%=request.getMethod() %><br>
  <%-- post방식 : 자바스크립트,<form> --%>
  서버주소 : <%=request.getServerName() %><br>
  서버포트 : <%=request.getServerPort() %><br>
  ★클라이언트IP : <%=request.getRemoteAddr() %><br>
  <%-- 조회수 증가할 때 같은 ip주소로 여러번 접속하면 계속 증가되므로, 방지하기 위해 IP주소가 필요 --%>
  <%--  WebSocket : 실시간 상담 => ip를 알고 있어야 해당 개인에게만 보낼 수 있음 --%>
  ★URL : <%=request.getRequestURL() %><br>
  ★URI : <%=request.getRequestURI() %><br>
  ★ContextPath : <%=request.getContextPath() %><br>
  브라우저 : <%=request.getHeader("User-Agent") %>
</body>
</html>