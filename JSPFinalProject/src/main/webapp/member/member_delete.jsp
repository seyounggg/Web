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
	width:350px;
}
</style>
<script src="https://code.jquery.com/jquery.js"></script>
<script>
$(function(){
	$('#delBtn').click(function(){
		let pwd=$('#pwd').val()
		if(pwd.trim()==""){
			$('#pwd').focus
			return;
		}
		$.ajax({
			type : 'post',
			url: '../member/member_delete_ok.do',
			data:{"pwd":pwd},
			success: function(result){
				let res=result.trim();
				if(res=='NO'){
					alert('비밀번호가 틀립니다.');
					$('#pwd').val("");
					$('#pwd').focus();
					return;
				} else {
					alert('회원 탈퇴 완료!!');
					location.href="../main/main.do";
				}
			}
		})
	})
})
</script>
</head>
<body>
<div class="wrapper row3">
  <main class="container clear">
    <h2 class="sectiontitle">회원 탈퇴</h2>
    <div class="row">
      <table class="table">
        <tr class="text-center">
          <td class="inline">
            비밀번호 입력 : <input type=password id="pwd" class="input-sm">
          </td>
        </tr>
        <tr>
          <td class="text-center inline">
            <input type=button value="회원탈퇴" id="delBtn" class="btn btn-sm btn-danger">
            <input type=button value="취소" class="btn btn-sm btn-info" onclick="javascript:history.back()">
          </td>
        </tr>
      </table>
    </div>
  </main>
</div>
</body>
</html>