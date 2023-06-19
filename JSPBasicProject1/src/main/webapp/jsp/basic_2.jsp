<%--
	JSP => HTML+Java => 구분해서 사용해야함(스크립트)
	
	- 스크립트(자바 코딩 영역)
		= 선언문 : <%! %> => 메소드, 멤버변수 선언
		= 표현식 : <%= %> => out.println() => 자바 변수 출력
		= 스크립트릿 : <% %> => 일반 자바(메소드 영역)
							메소드 호출, 지역변수 설정, 제어문...
		a.jsp
		<%
			int a=10;
			public void display(){}
		%>
		<%
			String name="홍길동";
		%>
		<div>
		  <%=name%>
		</div>
		
		=> 자바로 변경
		public class a_jsp extends HttpServlet {
		
			---------------------------------- <%! %> 영역 (=> 클래스 영역(블록))
			int a=10;
			public void display(){}
			----------------------------------  => Service 영역
			public void _jspInin(){}
			public void _jspDestroy(){}
			public void jspServlet(){ => <% %> 영역
				String name="홍길동";
				out.write("<div>");
				out.write(name); => <%=name%> 영역
				out.write("</div>");
			}
			---------------------------------- 
		}
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	width: 500px;
}
h1{
	text-align: center;
}
</style>
</head>
<body>
  <div class="container">
	<h1>구구단</h1>
	<div class="row">
	  <table class="table">
	    <tr>
	      <%-- 자바 문법 적용 --%>
	      <%--
	      		한줄 주석 //
	      		여러줄 주석 /* */
	      		문장 종료시 => ;
	      		out.println( __ )
	      		             → <%= %>
	      --%>
	      <% for(int i=2;i<=9;i++){ %>
	        <th class="text-center"><%= i+"단" %></th>
	      <% }%>
	    </tr>
	    <% for(int i=1;i<=8;i++){ %>
	    	<tr>
	    <%
			// HTML 안에서는 자바는 일반 텍스트
			// 자바안에서 HTML은 일반 텍스트
			// 자바 / HTML 구분 잘 해야한다!
			// <!-- --> 사라지지 않는다
	    	for(int j=2;j<=9;j++){ %>	
	    		<td class="text-center">
	    		<%=j+"*"+i+"="+(j*i) %>
	    		</td>
	    	<%} %>
	    	</tr>
	    <% } %>	
	  </table>
	</div>
	</div>
</body>
</html>