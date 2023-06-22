<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	application : ServletContext
	: 서버관리(서버에 대한 정보, 로그 정보, 자원 관리)
		= 서버 버전 : servlet에 버전
			1) getServerInfo() : 서버이름(우리는 => 톰캣)
			2) getMajorVersion()
			3) getMinorVersion()
				17.01 , 3.5 ...
				-- --  5 (보안)
					   6 (분산) => cloud
			4) log
			***5) getRealPath() : 자원관리 (파일)
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
서버이름 : <%=application.getServerInfo() %><br>
버전 : <%=application.getMajorVersion() %><br>
부버전 : <%=application.getMinorVersion() %><br>
<%-- MIME : <%=application.getMimeType("application_1.jsp") %> --%>
</body>
</html>