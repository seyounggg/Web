<%--
	자바 / HTML
	=> <%! %>
	=> <%= %>
	=> <% %>
	------------ 자바 코딩 영역
	
	1. 지시자
		1) page : JSP 파일의 정보 / 139page
			형식 : <%@ page 속성=값 ... %> => 속성마다 1번만 사용 가능
					=> 번역되는 태그가 선언하는 태그
					=> 생략 시 한글이 깨진다
					=> JSP는 <%@ page로 시작을 해야한다 / ★무조건 첫줄에 써야한다(중간에 쓸 수 없음)
			1. info
				정보 => 작성자 / 수정일 ...
			2. contentType
				변환 => 브라우저에 알려준다(실행결과)
				text/html;charset=UTF-8 => HTML
				text/xml;charset=UTF-8 => XML
				text/plain;charset=UTF-8 => JSON
			3. import
				자바 라이브러리 읽기
				=> 사용자 정의 읽기
				=> 자동추가
					java.lang.*
					java.servlet.*
				=> 형식
					<%@ page import="java.util.* , java.sql.* ..." %> => , 로 구분해서 여러개를 작성할 수 있고,
					<%@ page import="java.util.*"%> => 각각 작성해도 된다
					<%@ page import="java.sql.*"%>
			4. buffer : HTML을 출력할 메모리 공간
						8kb => 16kb ==>
						buffer="16kb"				
			5. errorPage : 에러발생시에 이동하는 파일 지정
			6. isErrorPage : 종류별 에러 처리
		2) taglib
		3) include
		
	★★★속성 작성 시 "" (속성="값") // ""빠지면 오류!!★★★
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>JSP 시작점</h1>
</body>
</html>