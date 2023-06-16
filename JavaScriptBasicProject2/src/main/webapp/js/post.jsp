<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.sist.dao.*"%>
<%-- 
	JSP는 메소드 영역!!
	_jspService() { => 브라우저에 실행하는 메소드 => service
		====
		JSP
		====
	}
--%>
<%--
	실행시에 JSP => servlet 클래스로 변경
			  톰캣
	post.jsp => post_jsp.java
				-------------
				|
				compile
				|
				post_jsp.class
				|
				인터프리터
				|
				메모리에 HTML만 출력한다
				------------------- 버퍼 => 브라우저에서 읽어서 출력
			변환 => 다른 프로그램과 연결 WAS
								  ---- 톰캣
								  web Application Server
			1) 구성요소
				=> AWS : Java / Tomcat => 프로젝트 파일을 묶어서 올려준다
				server : web Server => 아파치/IIS
							| 연결:WAS(미들웨어) => 톰캣(연습용 웹서버가 내장)
				client : 브라우저
	JSP => Java Server Page => 서버에서 실행하는 자바 파일
	==== 스크립트 형식
	1) 지시자
		= page
			<%@ page 속성=값...%> : JSP 파일 정보
			속성 
				= contentType : 브라우저와 연결 => 파일형태를 알려주는 역할
					text/html => html
					text/xml => xml
					text/plain => json
				--------------------------default:영어 => charset=UTF-8
				= import : 다른 라이브러리를 로딩할 때 사용
					<%@ page import="java.util.*", java.io.*..."%> -- 한번에 다 같이 적어도 되고, 
					<%@ page import="java.util.*"%> -- 따로따로 작성도 가능
					<%@ page import="java.io.*"%>
				= errorPage : error가 발생 시 이동하는 파일을 지정
					<%@ page errorPage="error.jsp"%>
				= 파일의 확장자는 변경이 가능하다(.do, .nhn...)
		-------------------------------------------------------------------------------------
		= include 지시자 : JSP안에 특정위치 다른 JSP를 포함
			<%@ include file="a.jsp"%>
		-------------------------------------------------------------------------------------
		= taglib 지시자 : 자바의 제어문, 변수 선언, String ..	=> 태그로 만들어서 제공
			<%
				for(int i=0;i<=10;i++){
			%>
				<ul>
				</ul>
			<%
				}
			%>
				↓ (Spring에서 JSP 사용 시 (MVC))
			<c:forEach var="i" begin="0" end="10" step="1">
				<ul>
				</ul>
			</c:forEach>
		
	1-1) 스크립트릿(자바언어 분리)
		= 선언식 : <%! 메소드 선언, 전역번수 %> => 사용빈도가 없다
		= 표현식 : <%= 화면 출력 내용 %> => out.println()
		= 스크립트릿: <% 일반 자바 : 지역변수, 메소드 호출, 객체 생성, 제어문 %>
	
	2) 내장객체(자바에서 지원하는 객체)
		★★★= request : 사용자가 보내준 데이터 관리
		★★★= response : 응답(HTML,Cookie)
		★★★= session : 서버에 사용자 정보 일부 저장, 장바구니 ...
		★★★= application : 서버 관리 => getRealPath()
		★★★= out : <%= %>
		★★★= pageContext : 페이지 흐름
			<jsp:include> <jsp:forward> => JSP액션태그로 변경
			= config : (web,xml)
		★★★= exception : (try~catch)
		★★★= page : (this)
	
	3) JSP 액션 태그
		<jsp:useBean> : 클래스 객체 생성
		<jsp:setProperty> : set메소드에 값을 채운다
		<jsp:getProperty> : get메소드 호출
		<jsp:param> : 데이터 전송
		<jsp:include> : 특정위치에 다른 JSP를 추가
		<jsp:forward> : 화면을 이동
			= sendRedirect() => request를 초기화
			= forward() => request를 계속 유지
	
	4) ★★★JSTL / EL
		= JSTL(Java Standard Tag Library) : 태그로 자바 라이브러리를 만들어 준다
		= EL : 화면 출력 => <%= %> (X) => ${}
	
	5) ★★★MVC :  자바 / HTML을 분리해서 코딩
			(Model) (View)
			--------------
			연결 => Controller(서블릿)
--%>
<%
	// 자바영역
	// DAO가져오기
	MemberDAO dao=MemberDAO.newInstance();
	request.setCharacterEncoding("UTF-8");
	String dong=request.getParameter("dong");
	// dong에 값이 들어가지 않은 상태로 먼저 출력하기 때문에 오류가 발생한다(500)
	// 그래서 null값일 때를 처리해줘야 한다
	int count=0;
	List<ZipcodeVO> list=null;
	if(dong!=null){
		count=dao.postfindCount(dong);
		list=dao.postfind(dong);
	}
	
	//Model1(JSP) => MV구조 => MVC
%>

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
	width: 450px;
}
h1{
	text-align: center;
}
td, th{
	font-size: 9px;
}
a {
	text-decoration: none;
	color: black;
}
a:hover {
	text-decoration: underline;
	color: cyan;
}
</style>
<script type="text/javascript">
let ok=(zip,addr)=>{
	// opener => js7.html (팝업창을 열어주는 파일)
	opener.frm.post1.value=zip.substring(0,3);
	opener.frm.post2.value=zip.substring(4,7);
	opener.frm.addr.value=addr;
	self.close(); // 자신을 닫는다 => post.jsp
}
</script>
</head>
<body>
	<div class="container">
		<h1>우편번호 검색</h1>
		<div class="row">
		<form method=post action="post.jsp">
			<table class="table">
				<tr>
					<td>
					우편번호 : <input type=text name=dong size=15 class="input-sm">
					<input type=submit value="검색" class="btn btn-sm btn-danger">
					</td>
				</tr>
			</table>
		</form>
		<div style="height:20px"></div>
		<%
			if(list!=null){
		%>
			<table class="table">
				<tr>
					<th width=20% class="text-center">우편번호</th>
					<th width=80% class="text-center">주소</th>
				</tr>
				<%
					if(count==0){
				%>
					<tr>
						<td colspan="2" class="text-center">
							<h3>검색된 결과가가 없습니다</h3>
						</td>
					</tr>
				<%
					}
					else {
						for(ZipcodeVO vo:list){
				%>
						<tr>
							<td width=20% class="text-center">
							<%= vo.getZipcode() %>
							</td>
							<td>
								<a href="javascript:ok('<%=vo.getZipcode() %>','<%=vo.getAddress() %>')"><%=vo.getAddress() %></a>
							</td>
						</tr>
				<%
						}
					}
				%>
			</table>
		<%
			}
		%>
		</div>
	</div>
</body>
</html>