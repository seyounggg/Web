<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@300;500&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">

.container{
	margin-top: 50px;
}
.row{
	margin: 0px auto;
	width: 450px;
}
h1{
	text-align: center;
	font-family: 'Gasoek One', sans-serif;
}
</style>
<!-- import -->
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
//자바스크립트 라이브러리
/*
	let id=document.querySelector("#id")
	       ---------------------- => JQUERY => $('#id')
	       => 값을 읽은 경우
	       		id.value  => $('#id').val()
	       		--------
	       		id.textContent  => $('#id').text()
	       		--------------
	       		id.innerHTML  => $('#id').html
	       		------------  $('#id').attr() => 속성값 읽을 때
 */
$(function(){ //window.onload=function(){}
	// 둘다 똑같이 logBtn에 이벤트 등록하는 방법
/* $('#logBtn').click(function(){
		alert("Hello Jquery!!")
	}) */
	
	$('#logBtn').on('click',function(){
		// alert("Hello Jquery!!") - 연습용
		let id=$('#id').val()
		//= let id=docunet.querySelector('#id').value
		if(id.trim()===""){
			$('#id').focus()
			return;
		}
		let pwd=$('#pwd').val()
		if(pwd.trim()===""){
			$('#pwd').focus()
			return;
		}
		//$('#frm').submit();
		$.ajax({
			type:'post',
			url:'login_ok.jsp',
			data:{"id":id,"pwd":pwd},
			success:function(result){ //result는 그냥 변수명
				// login_ok.jsp에서 보내온 결과값을 result에 담는다
				// -> result값을 res에 담아서 조건문을 수행한다
				// -> 조건문의 수행결과를 출력한다!
				let res=result.trim()
				if(res==='NOID'){
					$('#id').val("")
					$('#pwd').val("")
					$('#id').focus()
					$('#print').text("아이디 존재하지 않습니다")
				}else if(res==='NOPWD'){
					$('#pwd').val("")
					$('#pwd').focus()
					$('#print').text("비밀번호가 틀립니다")
				}else{
					location.href="../databoard/list.jsp"
				}
			}
		})
	})
})
</script>
</head>
<body>
  <div class="container">
    <h1>Login</h1>
    <div class="row">
      <form method=post action="login_ok.jsp" id=frm>
        <table class="table">
          <tr>
            <td width=20%>ID</td>
            <td width=80%>
              <input type=text name=id size=15 class="input-sm" id="id">
            </td>
          </tr>
          <tr>
            <td width=20%>PassWord</td>
            <td width=80%>
              <input type=password name=pwd size=15 class="input-sm" id="pwd">
            </td>
          </tr>
          <tr>
            <td colspan=2 class="text-center">
              <span id="print" style="color:red"></span>
            </td>
          </tr>
          <tr>
            <td colspan=2 class="text-center">
              <input type=button class="btn btn-sm btn-danger" value=로그인 id="logBtn">
            </td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</body>
</html>