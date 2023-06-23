<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.sist.dao.*"%>
<jsp:useBean id="dao" class="com.sist.dao.DataBoardDAO"></jsp:useBean>
<%
	String no=request.getParameter("no");
	String bno=request.getParameter("bno");
	// 삭제 후 내용보기(댓글 있는 위치)로 이동해야하므로 bno가 필요 -> 다시 돌아와야해서
	
	dao.replyDelete(Integer.parseInt(no));
	
	//이동
	response.sendRedirect("detail.jsp?no="+bno);
%>
