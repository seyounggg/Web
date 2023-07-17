<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.row{
	margin: 0px auto;
	width:600px;
}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$( function() {
	$( "#tabs" ).tabs();
	$('#emailBtn').click(function(){
		let email=$('#email').val();
		if(email.trim()==""){
			$('#email').focus();
			return;
		}
		$.ajax({
			type:'post',
			url:'../member/idfind_ok.do',
			data:{"email":email},
			success:function(result){ // 200(정상수행)
				let res=result.trim();
				if(res==='NO'){
					// email이 없는 경우 => email이 존재하지 않습니다.
					$('#id_email').html('<span style="color:red">이메일이 존재하지 않습니다</span>');
				} else {
					// email이 있는 경우 => id 출력
					// ex) shim => s*** 이렇게 출력
					$('#id_email').html('<span style="color:blue">'+res+'</span>');
				}
			}
			/* error: function (request, status, error) {
		        console.log("code: " + request.status)
		        //status : 404,500,403,412...
		        console.log("message: " + request.responseText)
		        // error Message
		        console.log("error: " + error);
		        // 무슨 에러가 발생했는지?
		    } */
		})
	})
	$('#telBtn').on('click',function(){
		
	})
} );
</script>
</head>
<body>
  <div class="wrapper row3">
    <main class="container clear">
      <h2 class="sectiontitle">아이디찾기</h2>
      <div class="row">
        <div id="tabs">
		  <ul>
		    <li><a href="#tabs-1">이메일로 찾기</a></li>
		    <li><a href="#tabs-2">전화번호로 찾기</a></li>
		  </ul>
		  <div id="tabs-1">
		    <table class="table">
		      <tr>
		        <td class="inline">
		          이메일 : <input type=text id="email" class="input-sm">
		          <input type=button value="검색" class="btn btn-sm btn-danger" id="emailBtn">
		        </td>
		      </tr>
		      <tr>
		        <td class="text-center"><h3 id="id_email"></h3></td>
		      </tr>
		    </table>
		  </div>
		  <div id="tabs-2">
		    <table class="table">
		      <tr>
		        <td class="inline">
		          전화번호 : <input type=text id="tel" class="input-sm">
		          <input type=button value="검색" class="btn btn-sm btn-danger" id="telBtn">
		        </td>
		      </tr>
		      <tr>
		        <td class="text-center"><h3 id="id_tel"></h3></td>
		      </tr>
		    </table>
		  </div>
		</div>
      </div>
    </main>
  </div>
</body>
</html>