<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 301page
	Session/Cookie : 상태를 지속적으로 유지
					----- 값 변경(데이터 관리) => (react/vue => state)
	Session VS Cookie
		------------------------------------------------------
				Session						Cookie
		------------------------------------------------------
		클래스명	(내장객체)						(필요시마다 생성)
				HttpSession					Cookie
		형식)
		HttpSession session=request.getSession() => interface
		Cookie cookie=new Cookie() => 일반클래스
		------------------------------------------------------
		저장값	자바에서 사용되는 모든 클래스		문자열만 저장
				(Object)
		------------------------------------------------------
		저장객체	서버안에 저장					클라이언트(브라우저)
				=> 구분(sessionID)
					getId() => WebSocket	
		------------------------------------------------------
		보안		보안(o)						보안(X)_취약하다
		------------------------------------------------------
		사용처	로그인(사용자 일부 정보)			최근방문
				장바구니
		------------------------------------------------------
		
	Cookie
		1. 생성
			Cookie cookie=new Cookie(String key, String value)
		2. 저장기간 설정
			cookie.setMaxAge(초) => 0이면 삭제
		3. 저장 path지정
			cookie.setPath("/")
		4. 저장된 cookie를 클라이언트 브라우저로 전송
			response.addCookie(cookie)
		5. Cookie읽기
			Cookie[] cookies=request.getCookies()
							---------------------
							저장된 쿠키 전체 읽기
		6. key 읽기  : getName()
		7. value 읽기 : getValue()
		
	Session(HttpSession)
		서블릿 => request.getSession()
		JSP => 내장객체(Session)
		---------------------- 서버에 저장
		=> 전역변수(모든 JSP에서 사용)
		=> 서버에 저장 (보안이 뛰어나다)
		
	★	1. 세션 저장
			session.setAttribute(String key, Object obj)
		2. 세션 저장 기간
			session.setMaxInactiveInterval(60*5_5분/초단위로 작성) => default : 30분(1800초)
	★	3. 세션 읽기
			Object session.getAttribute(String key)
			------ 리턴형이 Object => 형변환이 필요하다
	★	4. 세션 일부 삭제
			session.removeAttribute(String key)
	★	5. 세션 전체 삭제
			session.invalidate()
		6. 세션 생성 여부 확인
			session.isNew()
		7. 세션에 등록된 sessionId(각 클라이언트마다 1개만 생성) => 모든 정보
			session.getId()
		-----------------------------------------------------------------------------------
		저장방식 => Map형식(key,value)
					value는 중복이 가능
					key는 중복이 불가능 ===> 덮어쓴다
					Web에서 사용 => Map방식(request,response,session,application)
						★getParameter(String key)
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>