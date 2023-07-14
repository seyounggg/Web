<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%--
 	[BackEnd]
 	Model에서 처리 (비즈니스 로직) : Model (Model,VO,DAO)
 		Model : 브라우저 연결
 		VO : 데이터를 모아서 전송할 목적
 		DAO : 데이터베이스만 연결
 	[FrontEnd]
 	JSP에서 화면에 데이터 출력(프리젠테이션 로직)
 	
 	실무
 	1) DB단
 	2) Server단
 	3) View단
  --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h2 class="sectiontitle">공지수정</h2>
  <form method=post action="../adminpage/notice_update_ok.do">
    <table class="table">
      <tr>
        <th width=20% class="text-center">구분</th>
        <td width=80%>
          <select name="type">
            <option value="1" ${vo.type==1?"selected":"" }>일반공지</option>
            <option value="2" ${vo.type==2?"selected":"" }>이벤트공지</option>
            <option value="3" ${vo.type==3?"selected":"" }>맛집공지</option>
            <option value="4" ${vo.type==4?"selected":"" }>여행공지</option>
            <option value="5" ${vo.type==5?"selected":"" }>레시피공지</option>
          </select>
        </td>
      </tr>
      <tr>
        <th width=20% class="text-center">제목</th>
        <td width=80%>
          <input type=hidden name=no value=${vo.no }>
          <input type=text name=subject size=50 class="input-sm" value="${vo.subject }">
        </td>
      </tr>
      <tr>
        <th width=20% class="text-center">내용</th>
        <td width=80%>
          <textarea rows="10" cols="50" name=content>${vo.content }</textarea>
        </td>
      </tr>
      <tr>
        <td colspan=2 class="text-center">
          <button class="btn btn-sm btn-primary">등록</button>
          <input type=button class="btn btn-sm btn-success" value="취소" onclick="javascript:history.back()">
        </td>
      </tr>
    </table>
  </form>
</body>
</html>