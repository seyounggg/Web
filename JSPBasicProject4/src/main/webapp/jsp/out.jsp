<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.sist.dao.*"
	
%>
<%-- 
	JSP
	1. 지시자 : page / include / taglib
		page : JSP파일에 대한 정보를 가지고 있다
			1) contentType : 브라우저에 실행하는 타입
				html(text/html), xml(text/xml), json(text/plain)
				** 핵심!! json(text/plain)
					Ajax/Vue/React => RestFul
			2) import : 라이브러리 읽기 (여러번 사용 가능)
			3) errorPage : 에러시에 에러 출력 화면으로 이동
			4) buffer : html태그를 저장하는 공간(소스미리보기)
				=> 사용자마다 한개만 생성한다(브라우저가 연결해서 읽어가는 위치)
	2. 스크립트 : 자바 / HTML을 분리해서 소스 코딩
	   ------ 자바언어 코딩 위치 (위치에서 벗어나서 코딩하면 일반 텍스트로 인식)
		<%!   %> : 선언문(멤버변수,메소드 선언)
				=> 클래스 제작 시 클래스 블록안에 들어간다 => 사용빈도 ↓
				=> 자바클래스를 만들어서 메소드를 호출
		<%    %> : 일반 메소드 영역 => 지역변수, 제어문, 루프, 메소드 호출...
				=> _jspService() {
						---------
						JSP에 첨부하는 소스
						---------
					}
		<%=   %> : 화면출력(변수, 문자열...) => out.println(<%= %>)
	3. 내장객체 : 미리 객체를 생성해서 필요한 위치에 사용이 가능하도록 만들었음
		request : HttpServletRequest
				사용자 정보를 담고있다(요청정보, 추가정보, 브라우저 정보)
				= 요청정보
					* getParameter() : 사용자가 전송한 데이터를 한개씩만 받는다
						-> return형이 String이다
					* getParmeterValues() : 사용자가 전송한 데이터를 여러개 받는다
						-> return형이 String[]  : 체크박스, select의 멀티...
					* setCharacterEncoding() : 디코딩 메소드
						-> POST 방식에서만 사용
						-> GET은 자동화 처리 => window10이상
							============ server.xml(한글처리, 포트)
							8080은 프록시서버
				= 추가정보 (MVC,MV) : 오라클에서 받은 값을 추가해서 JSP로 전송
					* setAttribute() : 기존에 있던 request값에 출력에 필요한 데이터를 전송
					* getAttribute() : 추가해서 보낸 데이터를 받을 경우에 사용
					----------------- session에도 getAttribute,setAttribute가 있다
				= 브라우저 정보
					* getRemoteAddr() : 접속자의 IP
					* getRequestURL(), getRequestURI(), getContextPath()
		response : 응답정보, 화면 이동 정보 => HttpServletResponse
			= 응답정보
				* setContextType() : HTML,XML
					=> page지시자안에 있다
				* addCookie() : 쿠키 전송
					=> 각 JSP에서 HTMl을 전송하던가, cookie를 전송하던가...한번만 수행할 수 있다
			= 화면 이동 정보 : 필요시에 서버에서 화면을 요청화면이 아닌 다른 화면으로 이동
				* sendRedirect() : GET방식 , request를 초기화한 다음에 이동
				예) login 요청 -> main으로 이동
					(로그인 과정을 보여줄 수 없으니까 로그인이 완료된 메인화면으로 이동)
					insert 요청 -> list로 이동
					(추가하는 과정을 보여줄 수 없으니까 추가가 된 리스트 목록을 보여주는 것)
			= Header 정보 : 실제 데이터 전송 전에 처리
				* setHeader() : 한글 변환 / 다운로드 시 파일명, 크기를 보낸다 (=> 다운로드창 띄워주기)
		out : 출력 버퍼 관리 (Class = JspWriter) __ 175page
			= 출력(메모리)
				* println() <%= %>
			= 메모리 확인
				* getBufferSize() : 총 버퍼 크기
				* getRemaining() : 사용중인 버퍼 크기
			= 버퍼 지우기
				* clear() 
		-----------------------------------------------------
		session
		application
		pageContext
		-----------------------------------------------------
		config : web.xml처리(환경 설정)
		exception : try ~ catch
		page : this
--%>
<%-- out객체 사용법 (복잡한 HTML구조) print --%>
<%-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  
</body>
</html> --%>
<%
EmpDAO dao=new EmpDAO();
List<EmpVO> list=dao.empListData();

out.print("<!DOCTYPE html>");
out.print("<html>");
out.print("<head>");
out.print("<meta charset=\"UTF-8\">");
out.print("<title>Insert title here</title>");
out.print("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css\">");
out.print("<style>");
out.print(".container{margin-top:50px}");
out.print(".row{margin:0px auto; width:800px}");
out.print("h1{text-align:center}");
out.print("</style>");
out.print("</head>");
out.print("<body>");
out.print("<div class=container>");
out.print("<h1>사원 목록</h1>");
out.print("<div class=row>");
out.print("<table class=\"table table-striped\">");
out.print("<tr class=success>");
out.print("<th class=text-center>사번</th>");
out.print("<th class=text-center>이름</th>");
out.print("<th class=text-center>직위</th>");
out.print("<th class=text-center>입사일</th>");
out.print("<th class=text-center>급여</th>");
out.print("<th class=text-center>성과급</th>");
out.print("<th class=text-center>부서명</th>");
out.print("<th class=text-center>근무지</th>");
out.print("<th class=text-center>호봉</th>");
out.print("</tr>");
for(EmpVO vo:list) {
	out.print("<tr>");
    out.print("<td class=text-center>"+vo.getEmpno()+"</td>");
    out.print("<td class=text-center><a href=\"MainServlet?mode=2&empno="+vo.getEmpno()+"\">"+vo.getEname()+"</a></td>");
    out.print("<td class=text-center>"+vo.getJob()+"</td>");
    out.print("<td class=text-center>"+vo.getDbday()+"</td>");
    out.print("<td class=text-center>"+vo.getDbsal()+"</td>");
    out.print("<td class=text-center>"+vo.getComm()+"</td>");
    out.print("<td class=text-center>"+vo.getDvo().getDname()+"</td>");
    out.print("<td class=text-center>"+vo.getDvo().getLoc()+"</td>");
    out.print("<td class=text-center>"+vo.getSvo().getGrade()+"</td>");
    out.print("</tr>");
}
out.print("</table>");
out.print("</div>"); // row
out.print("</div>"); // container
out.print("</body>");
out.print("</html>");
%>