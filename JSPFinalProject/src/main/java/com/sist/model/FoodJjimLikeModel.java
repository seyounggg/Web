package com.sist.model;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class FoodJjimLikeModel {
	@RequestMapping("jjim/jjim_insert.do")
	public String jjim_insert(HttpServletRequest request,HttpServletResponse response) {
		String fno=request.getParameter("fno");
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		FoodJjimLikeDAO dao=FoodJjimLikeDAO.newInstance();
		FoodJjimVO vo=new FoodJjimVO();
		vo.setFno(Integer.parseInt(fno));
		vo.setId(id);
		dao.foodJjimInsert(vo);
		
		return "redirect:../food/food_detail.do?fno="+fno;
		// redirect => request가 초기화된다 -> .do 다시 수행
		// sendRedirect() => 재호출 => .do (request를 초기화)
		/*
		 * 1. food_detail에서 찜하기를 누르면 찜하기 기능을 수행하고 다시 food_detail.jsp 화면을 보여줘야함
		 * 2. 지금 상태에서는 insert 만 하고 request에 담아서 전송할 값이 없기 때문에 sendRedirect 방식이 사용 가능하다
		 * ++ food_detail에서 jjimdao 처리 해뒀음(model확인)
		 */
		// request에 담긴 값을 보내고 싶으면 forward방식으로 보내야 한다 (.jsp) //forward는 새로운 데이터를 전송
	}
	
	@RequestMapping("like/like_insert.do")
	public String like_insert(HttpServletRequest request,HttpServletResponse response) {
		String fno=request.getParameter("fno");
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		FoodLikeVO vo=new FoodLikeVO();
		vo.setId(id);
		vo.setFno(Integer.parseInt(fno));
		
		//dao 연결
		FoodJjimLikeDAO dao=FoodJjimLikeDAO.newInstance();
		dao.foodLikeInsert(vo);
		
		return "redirect:../food/food_detail.do?fno="+fno;
	}
}
