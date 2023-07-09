package com.sist.model;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class FreeBoardModel {
	
	@RequestMapping("board/list.do")
	public String board_list(HttpServletRequest request,HttpServletResponse response) {
		// JSP 첫줄에 나오는 코드 <%  %>
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		
		// dao연동
		FreeBoardDAO dao=FreeBoardDAO.newInstance();
		// 게시물 목록
		List<FreeBoardVO> list=dao.freeboardListData(curpage);
		// 총페이지
		int totalpage=dao.freeboardTotalPage();
		
		// 출력에 필요한 데이터를 모아서 전송 => board / list.jsp 가 받는다
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("list", list);
		// board / list.jsp로 전송
		request.setAttribute("main_jsp", "../board/list.jsp");
		// main_jsp => 화면출력부분 // request는 main.jsp로 보내고 -> board.list.jsp와 공유한다
		//main이 받는 모든 request를 공유한다!!
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	// 데이터 추가
	@RequestMapping("board/insert.do")
	public String board_insert(HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("main_jsp", "../board/insert.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/insert_ok.do")
	public String board_insert_ok(HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		FreeBoardVO vo=new FreeBoardVO();
		vo.setName(request.getParameter("name"));
		vo.setSubject(request.getParameter("subject"));
		vo.setContent(request.getParameter("content"));
		vo.setPwd(request.getParameter("pwd"));
		FreeBoardDAO dao=FreeBoardDAO.newInstance();
		dao.freeboardInsert(vo);
		
		return "redirect:../board/list.do"; // 실행을 다시 하도록!(.jsp 안되고, .do를 호출해야해 _ 데이터를 가져와야하니까)
	}
	
	// 상세보기
	// JSP -> DispatcherServlet -> Model -> DispatcherSerlet -> JSP
	//		  -----------------				---------------- spring.jar로 고정
	// Model : Model / DAO / VO (세개를 묶어서 다 모델이라고 한다)
	// 화면출력 => main / ajax => 일반jsp / _ok.do => redirect / 
	@RequestMapping("board/detail.do")
	public String board_detail(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		FreeBoardDAO dao=FreeBoardDAO.newInstance();
		FreeBoardVO vo=dao.freeboardDetailData(Integer.parseInt(no));
		
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../board/detail.jsp");
		
		// no(게시글번호)에 맞는 댓글 읽어오기
		FreeBoardReplyDAO fdao=FreeBoardReplyDAO.newInstance();
		List<FreeBoardReplyVO> list=fdao.replyListData(Integer.parseInt(no));
		request.setAttribute("list", list);
		
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	//Ajax
	@RequestMapping("board/delete.do")
	public void board_delete(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		String pwd=request.getParameter("pwd");
		
		FreeBoardDAO dao=FreeBoardDAO.newInstance();
		String res=dao.freeboardDelete(Integer.parseInt(no), pwd);
		try {
			PrintWriter out=response.getWriter();
			out.println(res); // => out.println 값을 Ajax에서 읽어서 처리 / res => YES or NO
		} catch (Exception e) {}
	}
	
	@RequestMapping("board/update.do")
	public String board_update(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		// db연동
		FreeBoardDAO dao=FreeBoardDAO.newInstance();
		FreeBoardVO vo=dao.freeboardUpdateData(Integer.parseInt(no));
		
		// request를 통해 값을 보낸다
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../board/update.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/update_ok.do")
	public String board_update_ok(HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		FreeBoardVO vo=new FreeBoardVO();
		vo.setName(request.getParameter("name"));
		vo.setSubject(request.getParameter("subject"));
		vo.setContent(request.getParameter("content"));
		vo.setPwd(request.getParameter("pwd"));
		vo.setNo(Integer.parseInt(request.getParameter("no")));
		FreeBoardDAO dao=FreeBoardDAO.newInstance();
		boolean bCheck=dao.freeboardUpdate(vo);
		
		request.setAttribute("bCheck", bCheck);
		request.setAttribute("no", vo.getNo());
		return "../board/update_ok.jsp";
	}
	
}
