<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	JSP 공부 순서
	1. 동작 순서
		1) client 요청(주소창을 이용해서 서버에 연결)
		http://localhost:8080/JSPBasicProject2/jsp/request.jsp
		--------------------  ---------------------------------
				서버관련					client요청 관련
					-----------------------  |
					(두개를 묶은거)URL			URI
		http => protocol
		localhost => serverIP
		8080 => port
		JSPBasicProject2 => ContextPath
		
		getURL => http://localhost:8080/JSPBasicProject2/jsp/request.jsp
		getContextPath => JSPBasicProject2 
		이렇게 가져올 수 있다!
		
		2) DNS를 거쳐서 => localhost(도메인) => ip변경
		3) ip/port를 이용해서 서버에 연결
			new Socket(ip,port) => TCP
		-----------------------------------------------------------------
		4) Web Server
			httpd
				= HTML,XML,CSS,JSON => Web Server 자체에서 처리후에 브라우저로 전송
				= JSP/Servlet은 자체적으로 처리하지 못함
				  -----------
						|
					Web Container(WAS)
					=> Java로 변경 => 컴파일 => 실행(실행결과를 메모리에 모아둔다)
		5) 메모리에 출력한 내용을 브라우저로 응답
	
		JSP (Java Server Page) : 서버에서 실행되는 자바파일
			1) _jspInit() : web.xml => 초기화
			2) _jspService() => 사용자 요청을 처리하고 결과값을 HTML로 전송
			  -------------- 메소드 안쪽이 공백으로 되어있음
			  {
			  	이 영역에 소스코딩을 할 수 있다 => JSP
			  }
			3) _jspDestroy() => 새로고침, 화면이동 ...메모리에서 해제
			
			public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
			{
				final javax.servlet.jsp.PageContext pageContext;
			    javax.servlet.http.HttpSession session = null;
			    final javax.servlet.ServletContext application;
			    final javax.servlet.ServletConfig config;
			    javax.servlet.jsp.JspWriter out = null;
			    final java.lang.Object page = this;
			    javax.servlet.jsp.JspWriter _jspx_out = null;
			    javax.servlet.jsp.PageContext _jspx_page_context = null;
			    
			    소스 코딩 영역
			    (이 안에서 코딩하기 때문에 session,pageContext,request...등 객체 사용이 가능하다 // 내장객체)
			    =>  JSP
			}
	
	2. 지시자
		page : JSP파일에 대한 정보를 갖고있다
			형식) <%@ page 속성="" 속성="" %>
			속성)
				ContentType="text/html | text/xml | text/plain(=>RestFul)" = 브라우저에 어떤 파일인지 알려준다
								HTML		XML				JSON
				import : 라이브러리 읽기
					import="java.util.*, java.io.*"
				errorPage : error시 이동페이지 지정(파일명)
				buffer
					buffer="8kb" => 16kb 32kb...
	
	3. 스크립트 사용법
		자바 코딩 영역
		<%! %> : 선언문(메소드, 멤버변수 등 선언) => 사용빈도 거의 없음
		<%= %> : 화면출력 => out.println(_ 이 부분임 _)
		<%  %> : 제어문, 메소드 호출, 지역변수 ...등
		JSP = Model1은 2023유행 => model2(MVC) => Domain(MSA)
          ----------------      |            |
                          Spring 4      Spring5/6
      => 표현식 , 스크립트릿
        ${}      JSTL
      => JSP안에서는 태그형으로 제작
		
	4. 내장객체 => 165page
		9가지 지원
         ***** request => HttpServletRequest
         request는 관리자 => 톰캣
         1) 서버정보 / 클라이언트 브라우저 정보
            getServerInfo()
            getPort()
            getMethod()
            getProtocol()
            ***getRequestURL()
            ***getRequestURI()
            ***getContextPath()
         2) 사용자 요청 정보
            데이터 전송시 => 데이터가 request에 묶여서 들어온다
            = 단일 데이터
               String getParameter()
            = 다중 데이터
               String[] getParameterValues() => checkbox, select => multiline
            = 한글 변환 (디코딩)
               setCharacherEncoding => UTF-8
            = 키를 읽는다
               getParameterNames()
               받는파일명?no=1&name=aaa
               -------
               a.jsp?no=&name=aaa&hobby=a&hobby=b&hobby=c
               
         3) 추가 정보   
            setAttribute() : request 데이터 추가전송
            getAttribute() : 전송된 데이터 읽기
         *****= response => HttpServletResponse
            = Header 정보
              다운로드 => 파일명 , 크기
              setHeader()
            = 응답정보
               = HTML 전송 => text/html
               = Cookie 전송 => addCookie
            = 화면 이동
               = sendRedirect()
         *****= session => HttpSession
         **= out => JpsWriter
         ***= application = ServletConntext
         *****= pageContext => pageContext
         = page => Object (this)
         = exception => Exception => try~catch
         = config => SevletConfig => web.xml
		--------------------------------------------------------
		페이지 입출력
		request, response, out
		--------------------------------------------------------
		외부 환경 정보
		config
		--------------------------------------------------------
		서블릿 관련
		application, pageContext, session
		--------------------------------------------------------
		예외처리 관련
		exception
		--------------------------------------------------------
	5. 액션태그
	6. include
	7. cookie
	8. JSTL
	9. EL
	10. MVC
	
	String a=request.getParameter("a");
	String b=request.getParameter("a");
	String c=request.getParameter("a");
	String d=request.getParameter("a");
	String e=request.getParameter("a");
	String f=request.getParameter("a");
	String g=request.getParameter("a");
	String h=request.getParameter("a");
	String i=request.getParameter("a");
	String j=request.getParameter("a");
	== 위 코딩 => 한번에! <jsp:setProperty name="vo" property="*"/>
	
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
.container{
	margin-top : 50px;
}
.row{
	margin: 0px auto;
	width: 800px;
	height: 700px;
}
h1{
	text-align: center;
}
</style>
</head>
<!-- 170page예제 : getParameter, getParameterValues -->
<body>
  <div class="container">
    <h1>개인 정보</h1>
    <div class="row">
      <form method=post action="request_ok.jsp">
      <table class="table">
        <tr>
          <th class="text-center" width=20%>이름</th>
          <td width=80%>
            <input type=text name=name size=15 class="input-sm">
          </td>
        </tr>
        <tr>
          <th class="text-center" width=20%>성별</th>
          <td width=80%>
            <!-- 라디오버튼은 반드시 그룹(name이 동일해야함) // value값도 무조건!! 있어야함 -->
            <input type=radio name=sex value="남자" checked>남자
            <input type=radio name=sex value="여자">여자
          </td>
        </tr>
        <tr>
          <th class="text-center" width=20%>전화번호</th>
          <td width=80%>
          <!-- getParameter("tel") <- name속성의 값을 넣어준다 -->
          <!-- 자바랑 연결되어 있으면 항상 name값이 있어야 한다 -->
            <select name="tel" class="input-sm"> 
              <option>010</option>
            </select>
            <input type=text name=tel2 size=15 class="input-sm">
          </td>
        </tr>
        <tr>
          <th class="text-center" width=20%>소개</th>
          <td width=80%>
            <textarea rows="8" cols="50" name=content></textarea>
          </td>
        </tr>
        <tr>
          <th class="text-center" width=20%>취미</th>
          <td width=80%>
            <input type="checkbox" name=hobby value=운동>운동
            <input type="checkbox" name=hobby value=등산>등산
            <input type="checkbox" name=hobby value=낚시>낚시
            <input type="checkbox" name=hobby value=게임>게임
            <input type="checkbox" name=hobby value=공부>공부
            <input type="checkbox" name=hobby value=자전거>자전거
            <input type="checkbox" name=hobby value=여행>여행
            <input type="checkbox" name=hobby value=컴퓨터>컴퓨터
            <!-- 배열로 받아야 한다 -->
          </td>
        </tr>
        <tr>
          <td colspan=2 class="text-center">
            <button class="btn btn-sm btn-danger">전송</button>
          </td>
        </tr>
      </table>
      </form>
    </div>
  </div>
</body>
</html>