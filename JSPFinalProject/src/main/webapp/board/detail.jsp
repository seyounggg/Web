<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.row{
	margin: 0px auto;
	width: 600px
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
let i=0; // 전역변수
let u=0;
let k=0;
$(function(){
	$('#del').click(function(){
		if(i===0){
			$(this).text("취소")
			$('#delTr').show()
			i=1;
		} else {
			$(this).text("삭제")
			$('#delTr').hide()
			i=0;
		}
	})
	$('#delBtn').click(function(){
		let pwd=$('#pwd1').val()
		let no=$(this).attr('data-no')
		if(pwd.trim()==""){
			$('#pwd1').focus()
			return;
		}
		// delete.do?no=1$pwd=1111
		$.ajax({
			type: 'post',
			url:'../board/delete.do',
			data: {"no":no,"pwd":pwd},
			success: function(result){
				let res=result.trim()
				if(res==='NO'){
					alert("비밀번호가 틀립니다")
					$('#pwd1').val("")
					$('#pwd1').focus()
				} else {
					location.href="../board/list.do"
				}
			}
		})
	})
	// Update(수정버튼)
	$('.ups').click(function(){
		let no=$(this).attr("data-no")
		// 수정 버튼을 누를때 열려있는 수정창을 닫기위해서 작성
		$('.ups').text("수정")
		$('.reins').hide();
		$('.updates').hide()
		if(u===0){
			$(this).text("취소");
			$('#u'+no).show();
			u=1;
		} else {
			$(this).text("수정")
			$('#u'+no).hide()
			u=0;
		}
	})
	$('.ins').click(function () {
		let no=$(this).attr("data-no");
		$('.ins').text("댓글");
		$('.reins').hide();
		$('.updates').hide()
		if(k===0){
			$(this).text("취소");
			$('#i'+no).show();
			k=1;
		}else {
			$(this).text("댓글");
			$('#i'+no).hide();			
			k=0;
		}
	})
})
</script>
</head>
<body>
<div class="wrapper row3">
  <main class="container clear">
    <h2 class="sectiontitle">글보기</h2>
    <table class="table">
      <tr>
        <th width=20% class="text-center">번호</th>
        <td width=30% class="text-center">${vo.no }</td>
        <th width=20% class="text-center">작성일</th>
        <td width=30% class="text-center">${vo.dbday }</td>
      </tr>
      <tr>
        <th width=20% class="text-center">이름</th>
        <td width=30% class="text-center">${vo.name }</td>
        <th width=20% class="text-center">조회수</th>
        <td width=30% class="text-center">${vo.hit }</td>
      </tr>
      <tr>
        <th width=20% class="text-center">제목</th>
        <td colspan=3>${vo.subject }</td>
      </tr>
      <tr>
        <td colspan=4 class="text-left" valign="top" height="200">
          <pre style="white-space: pre-wrap;border: none;background-color: white">${vo.content }</pre>
        </td>
      </tr>
      <tr>
        <td colspan=4 class="text-right">
          <a href="../board/update.do?no=${vo.no }" class="btn btn-xs btn-info">수정</a>
          <span class="btn btn-xs btn-danger" id="del">삭제</span>
          <a href="../board/list.do" class="btn btn-xs btn-warning">목록</a>
        </td>
      </tr>
      <tr style="display: none" id="delTr">
        <td colspan=4 class="text-right inline">
          비밀번호:<input type=password name=pwd id=pwd1 size=10 class="input-sm">
          <input type=button value="삭제" class="btn btn-sm btn-primary" id=delBtn data-no=${vo.no }>
        </td>
      </tr>
    </table>
    <div style="height: 20px"></div>
    <div class="col-sm-8">
      <table class="table">
      <!-- 댓글 출력창 -->
      <tr>
        <td>
          <c:forEach var="rvo" items="${list }">
            <table class="table">
              <tr>
                <td class="text-left">
                  <c:if test="${rvo.group_tab>0 }">
                    <c:forEach var="i" begin="1" end="${rvo.group_tab }">
                      &nbsp;&nbsp;
                    </c:forEach>
                    <image src="image/re_icon.png">
                  </c:if>
                  ◑${rvo.name }&nbsp;(${rvo.dbday })
                </td>
                <td class="text-right">
                  <c:if test="${sessionScope.id!=null }">
                  <c:if test="${sessionScope.id==rvo.id }"> <!-- 본인이 쓴거면 버튼이 보인다 -->
                  <span class="btn btn-xs btn-success ups" data-no="${rvo.no }">수정</span> <!-- 본인 -->
                  <a href="../board/reply_delete.do?no=${rvo.no }&bno=${vo.no}" class="btn btn-xs btn-danger">삭제</a> <!-- 본인 -->
                  </c:if>
                  <span class="btn btn-xs btn-warning ins" data-no="${rvo.no }">댓글</span> <!-- 대댓글(로그인한 모든 사람 가능) -->
                  </c:if>
                </td>
              </tr>
              <tr>
                <td colspan=2><pre style="white-space: pre-wrap;background-color: white;border: none">${rvo.msg }</pre></td>
              </tr>
              <tr style="display: none" class="reins" id="i${rvo.no }">
		        <td colspan=2>
		          <form method=post action="../board/reply_reply_insert.do" class="inline">
		            <input type=hidden name=bno value="${vo.no }"> <!--bno는 detail로 이동하기 위한 board번호 -->
		            <input type=hidden name=pno value="${rvo.no }"> <!-- 댓글번호 -->
		            <textarea rows="5" cols="55" name="msg" style="float: left"></textarea>
		            <input type=submit value="댓글쓰기" style="width: 100px;height: 104px;background-color: green;color: white">
		          </form>
		        </td>
		      </tr>
              <tr style="display: none" class="updates" id="u${rvo.no }">
		        <td colspan=2>
		          <form method=post action="../board/reply_update.do" class="inline">
		            <input type=hidden name=bno value="${vo.no }"> <!--bno는 detail로 이동하기 위한 board번호 -->
		            <input type=hidden name=no value="${rvo.no }"> <!-- 댓글번호 -->
		            <textarea rows="5" cols="55" name="msg" style="float: left">${rvo.msg }</textarea>
		            <input type=submit value="댓글수정" style="width: 100px;height: 104px;background-color: green;color: white">
		          </form>
		        </td>
		      </tr>
            </table>
          </c:forEach>
        </td>
      </tr>
	  </table>
	  <c:if test="${sessionScope.id!=null }"><!-- 로그인된 상태에서 입력하도록! -->
	    <table class="table">
	    <!-- 새댓글 입력창 -->
	      <tr>
	        <td>
	          <form method=post action="../board/reply_insert.do" class="inline">
	            <input type=hidden name=bno value="${vo.no }">
	            <textarea rows="5" cols="60" name="msg" style="float: left"></textarea>
	            <input type=submit value="댓글쓰기" style="width: 120px;height: 104px;background-color: green;color: white">
	          </form>
	        </td>
	      </tr>
	    </table>
	  </c:if>
	</div>
	<div class="col-sm-4">
	    
	</div>
  </main>
</div>
</body>
</html>