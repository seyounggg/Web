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
	width:750px;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script>
$(function(){
	let no=$('#upBtn').attr('data-no')
	$('#upBtn').click(function(){
		let subject=$('#subject').val()
		let content=$('#content').val()
		$.ajax({
			type:'post',
			url:'../replyboard/update_ok.do',
			data:{"no":no,"subject":subject,"content":content},
			success:function(){
				location.href="../replyboard/list.do";
			}
		})
	})
})
</script>
</head>
<body>
  <div class="wrapper row3">
    <main class="container clear">
      <h2 class="sectiontitle">수정하기</h2>
      <div class="row">
        <form method=post action="../replyboard/update_ok.do">
        <table class="table">
          <tr>
            <th width=20% class="text-center">제목</th>
            <td width=80%>
              <input type=text name=subject size=50 class="input-sm" id="subject" value="${vo.subject }">
              <input type=hidden name=no value="${vo.no }">
            </td>
          </tr>
          <tr>
            <th width=20% class="text-center">내용</th>
            <td width=80%>
              <textarea rows=10 cols=50 name=content id=content>${vo.content }</textarea>
            </td>
          </tr>
          <tr>
            <td colspan=2 class="text-center">
              <input type=button class="btn btn-sm btn-success" value="글쓰기" id="upBtn" data-no="${vo.no }">
              <input type=button value="취소" class="btn btn-sm btn-info" onclick="javascript:history.back()">
            </td>
          </tr>
        </table>
        </form>
      </div>
    </main>
  </div>
</body>
</html>