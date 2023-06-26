<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
/*
	문서 객체(태그) 조작
	----------------
	text() : getter/setter
			값읽기 : $(태그).text()
			값 설정하기 : $(태그).text(값)
		=> <태그>값</태그> 예) <td> <th> <h1>...
		=> text를 이용해서 값을 첨부 => html은 그대로 출력
	val() : input, textarea, select
		val()
		val(value)
	attr() : 
		$(태그).attr("속성명") => 읽기()
		$(태그).attr("속성명","첨부할 값") => 태그의 속성에 값을 첨부
	html() : innerHTML => set
	append() : 여러개 동시에 처리
	trim() : 공백문자 제거
	------------------------------------------------------------
	
 */
 $(function(){
	 // 373 page
	 $('img').attr("src","cgv2.jpg") //예약
	 $('input[type="text"]').val("admin")
	 //$('img').css('width','250px')
	 //$('img').css('height','300px')
	 //$('img').css('width','250px').css('height','300px')
	 $('img').css({'width':'250px','height':'300px','border':'2px solid red'})
 })
</script>
</head>
<body>
  <img src=""><br>
  <input type=text id="id" size=20>
</body>
</html>