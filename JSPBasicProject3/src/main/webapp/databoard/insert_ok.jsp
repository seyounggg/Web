<%@page import="com.sist.vo.DataBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.sist.dao.*, java.io.*"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%
	// _ok.jsp => 이런 파일명이면, 기능만 처리 및 이동
	// 데이터베이스 처리 => list.jsp 로 이동
	
	//1.한글처리
	request.setCharacterEncoding("UTF-8");
	
	//1-2. 파일업로드 클래스 생성
	String path="c:\\download";
	int size=1024*1024*100; //최대 100MB까지 가능
	String enctype="UTF-8";//한글 사용 여부
	MultipartRequest mr=new MultipartRequest(request,path,size,enctype,
			new DefaultFileRenamePolicy());
	
	//2.요청데이터 받기
	String name=mr.getParameter("name");
	String subject=mr.getParameter("subject");
	String content=mr.getParameter("content");
	String pwd=mr.getParameter("pwd");
	
	//3.VO에 묶는다
	DataBoardVO vo=new DataBoardVO();
	vo.setName(name);
	vo.setSubject(subject);
	vo.setContent(content);
	vo.setPwd(pwd);
	
	String filename=mr.getOriginalFileName("upload");
	if(filename==null){ //upload가 안된상태
		vo.setFilename("");
		vo.setFilesize(0);
	}else{ //upload가 된 상태
		File file=new File(path+"\\"+filename);
		vo.setFilename(filename);
		vo.setFilesize((int)file.length());
	}
	
	//4.DAO로 전송
	DataBoardDAO dao=DataBoardDAO.newInstance();
	dao.databoardInsert(vo);
	
	//5.화면이동(list.jsp)
	response.sendRedirect("list.jsp");
%>