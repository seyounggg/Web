package com.sist.model;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

public class MyPageModel {
	
	@RequestMapping("mypage/mypage_main.do")
	public String mypage_main(HttpServletRequest request,HttpServletResponse response) {
		
		request.setAttribute("mypage_jsp", "../mypage/mypage_reserve.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/mypage_reserve.do")
	public String mypage_reserve(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		// dao연결
		ReserveDAO dao=ReserveDAO.newInstance();
		List<ReserveVO> list=dao.reserveInfoData(id);
		
		request.setAttribute("list", list);
		request.setAttribute("mypage_jsp", "../mypage/mypage_reserve.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	// id,name,admin => session에서 받아올 수 있음(session에 저장되어 있기 때문에)
	// 나머지는 ?뒤에 값을 전송하면 된다
	@RequestMapping("mypage/mypage_jjim_list.do")
	public String mypage_jjim_list(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		//dao연결
		FoodJjimLikeDAO dao=FoodJjimLikeDAO.newInstance();
		List<FoodJjimVO> list=dao.foodJjimListData(id);
		
		//request에 값 전송
		request.setAttribute("list", list);
		request.setAttribute("mypage_jsp", "../mypage/mypage_jjim.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	@RequestMapping("jjim/jjim_cancel.do")
	public String jjim_cancel(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		FoodJjimLikeDAO dao=FoodJjimLikeDAO.newInstance();
		dao.foodJjimCancel(Integer.parseInt(no));
		
		return "redirect:../mypage/mypage_jjim_list.do";
	}
	
	@RequestMapping("mypage/mypage_cart.do")
	public String mypage_cart(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		CartDAO dao=CartDAO.newInstance();
		List<CartVO> list=dao.mypageCartListData(id);
		
		request.setAttribute("list", list);
		request.setAttribute("mypage_jsp", "../mypage/mypage_cart.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		CommonModel.commonRequestData(request);
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/cart_cancel.do")
	public String mypage_cart_cancel(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("no");
		CartDAO dao=CartDAO.newInstance();
		dao.cartCancel(Integer.parseInt(no));
		return "redirect:../mypage/mypage_cart.do";
	}
}
