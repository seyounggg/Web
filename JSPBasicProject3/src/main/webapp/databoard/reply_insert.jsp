<%@page import="com.sist.vo.ReplyVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.sist.dao.*"%>
    <jsp:useBean id="dao" class="com.sist.dao.DataBoardDAO"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	String bno=request.getParameter("bno");
	String msg=request.getParameter("msg");
	String id=(String)session.getAttribute("id");
	String name=(String)session.getAttribute("name");
	
	ReplyVO vo=new ReplyVO();
	vo.setBno(Integer.parseInt(bno));
	vo.setMsg(msg);
	vo.setId(id);
	vo.setName(name);
	
	//DAO연동
	dao.replyInsert(vo);
	//이동
	response.sendRedirect("detail.jsp?no="+bno);
%>