<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	application 의 자원관리 : log, paht
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <%
  // web.xml에 등록된 내용을 읽어 올 수 있다
	String driver=application.getInitParameter("driver");
	String url=application.getInitParameter("url");
	String username=application.getInitParameter("username");
	String password=application.getInitParameter("password");
  
	/*System.out.println("driver : "+driver);
	  System.out.println("url : "+url);
	  System.out.println("username : "+username);
	  System.out.println("password : "+password); */
  
	application.log("driver : "+driver);
	application.log("url : "+url);
	application.log("username : "+username);
	application.log("password : "+password);
	/* 콘솔 출력내용
		6월 22, 2023 10:45:58 오전 org.apache.catalina.core.ApplicationContext log
		정보: driver : oracle.jdbc.driver.OracleDriver
		6월 22, 2023 10:45:58 오전 org.apache.catalina.core.ApplicationContext log
		정보: url : jdbc:oracle:thin:@localhost:1521:xe
		6월 22, 2023 10:45:58 오전 org.apache.catalina.core.ApplicationContext log
		정보: username : hr
		6월 22, 2023 10:45:58 오전 org.apache.catalina.core.ApplicationContext log
		정보: password : happy */
	String path=application.getRealPath("/");
	System.out.println("path:"+path);
	// path:C:\webDev\webStudy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPBasicProject4\
  %>
</body>
</html>