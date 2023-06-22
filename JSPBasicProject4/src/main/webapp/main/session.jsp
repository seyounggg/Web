<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	request/response/session => 웹 개발의 핵심
					 -------
	session : 프로그램의 실행하는 중 (유지하는 상태 자체를 session이라고 함)
		서버에 저장(서버에서 나가기 전까지 유지)
			=> 사용자의 정보를 지속적으로 관리
			=> 장바구니, 결제, 예약, 추천...
			=> session에 저장되면 모든 JSP에서 사용이 가능하다(전역변수)
		클래스명 : HttpSession
			=> 클라이언트마다 1개 생성 => id가 부여(구분자)
			=> sessionId 로 채팅, 상담...
		주요 메소드
			String getId() : 세션마다 저장 구분자
			setMaxinactiveInterval() => 저장기간을 설정
				=> 기본 default => 1800(초단위:30분)
				ex) 은행 웹사이트 (접속 유지 시간)
			isNew() : ID 할당 여부 확인
				=> 장바구니
			invalidate() : session에 저장된 모든 내용을 삭제
				=> 로그아웃
			setAttribute() : session에 정보를 저장
			getAttribute() : 저장된 데이터를 읽기
			removeAttribute() : 일부 삭제
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>HttpSession(session):177page</h1>
</body>
</html>