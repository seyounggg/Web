<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- import => <script></script> -->
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	//글자조작 => text(),html() (getter/setter)
	//태그조작 => append()
	//alert($('h1').text())
	$('#h').html('<span style=color:green>Hello Jquery!!!</span>')
})
</script>
</head>
<body>
  <h1><span style="color: red">Hello Jquery!</span>
    <div>Hello Jquery!!</div>
  </h1>
  <h1 id=h></h1>
</body>
</html>