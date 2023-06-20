<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//request.jsp에서 전송된 데이터를 받는다
	//1.한글 (2byte로 읽어온다 => Unicode /Unicode형식으로 바꿔주는게 request.setCharacterEncoding())
	request.setCharacterEncoding("UTF-8");
	//1) 이름(단일값) <input type=text name=name <-이부분!!
	String name=request.getParameter("name");
	String sex=request.getParameter("sex");
	String tel=request.getParameter("tel");
	String tel2=request.getParameter("tel2");
	String content=request.getParameter("content");
	//입력창 대부분은 getParameter로 받고 / checkbox => getParameterValues로 받는다 (이유:값이 여러개라서!!)
	String[] hobby=request.getParameterValues("hobby");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>전송된 값</h1>
이름 : <%=name %><br>
성별 : <%=sex %><br>
전화 : <%=tel+")"+tel2 %><br>
소개 : <%=content %><br>
취미 :
	<ul>
<%-- 	  <%
	    if(hobby!=null){
	    	for(String h:hobby){
	   %>
	   		<li><%=h %></li>
	   <%
	    	}
	    } else { 
	  %>
	  	<font color="red">취미가 없습니다!</font>
	  <%} %> --%>
	  <!-- if-else를 사용한 이유 : null값(취미 미선택)인데 for문을 돌릴 수 있기 때문에 값의 유무에 따라 처리방법을 지정 -->
	  <!-- try-catch 사용해도 결과는 똑같다! -->
	  <%
	  	try{
	  		for(String h:hobby){
	  %>
	  	<li><%=h %></li>
	  <%
	  		}
	  }catch(Exception e){
	  %>
	  	<font color="red">취미가 없습니다!</font>
	  <%
	  }
	  %>
	</ul>
</body>
</html>