package com.sist.model;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.*;
import com.sist.vo.*;
import com.sist.dao.*;

public class ReplyBoardModel {
	@RequestMapping("replyboard/list.do")
	public String replyboard_list(HttpServletRequest request,HttpServletResponse response) {
		// 목록 전송 => DAO
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		ReplyBoardDAO dao=ReplyBoardDAO.newInstance();
		List<ReplyBoardVO> list=dao.replyBoardListData(curpage);
		int totalpage=dao.replyBoardTotalPage();
		// Java -> jsp (request or session) 
		// session보다 request를 사용하는 이유는 : session은 설정해둔 기간동안 저장하고 있지만, request는 출력 후 페이지가 넘어가면 메모리에서 없어진다
		request.setAttribute("list", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("main_jsp", "../replyboard/list.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	@RequestMapping("replyboard/insert.do")
	public String replyboard_insert(HttpServletRequest request,HttpServletResponse response) {
		
		request.setAttribute("main_jsp", "../replyboard/insert.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	@RequestMapping("replyboard/insert_ok.do")
	public String replyboard_insert_ok(HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		}catch(Exception e) {}
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		String name=(String)session.getAttribute("name");
		
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		
		ReplyBoardVO vo=new ReplyBoardVO();
		vo.setId(id);
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		
		ReplyBoardDAO dao=ReplyBoardDAO.newInstance();
		dao.replyBoardInsert(vo);
		
		return "redirect:../replyboard/list.do";
	}
	
	@RequestMapping("replyboard/detail.do")
	public String replyboard_detail(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		
		ReplyBoardDAO dao=ReplyBoardDAO.newInstance();
		ReplyBoardVO vo=dao.replyBoardDetailData(Integer.parseInt(no));
		
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../replyboard/detail.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	@RequestMapping("replyboard/delete.do")
	public String replyboard_delete(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		ReplyBoardDAO dao=ReplyBoardDAO.newInstance();
		dao.replyBoardDelete(Integer.parseInt(no));
		
		return "redirect:../replyboard/list.do";
	}
	
	@RequestMapping("replyboard/update.do")
	public String replyboard_update(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		ReplyBoardDAO dao=ReplyBoardDAO.newInstance();
		ReplyBoardVO vo=dao.replyBoardUpdateData(Integer.parseInt(no));
		
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../replyboard/update.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	@RequestMapping("replyboard/update_ok.do")
	public void replyboard_update_ok(HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (Exception e) {}
		String no=request.getParameter("no");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		
		//System.out.println("no:"+no+"subject:"+subject+"content:"+content);
		
		ReplyBoardDAO dao=ReplyBoardDAO.newInstance();
		ReplyBoardVO vo=new ReplyBoardVO();
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setNo(Integer.parseInt(no));
		
		dao.replyBoardUpdate(vo);
	}
}
