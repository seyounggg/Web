package com.sist.model;

import com.sist.controller.RequestMapping;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.dao.*;
import com.sist.vo.*;
public class CartModel {
	@RequestMapping("cart/cart_insert.do")
	public String cart_insert(HttpServletRequest request,HttpServletResponse response) {
		String goods_no=request.getParameter("goods_no");
		String price=request.getParameter("price");
		String type=request.getParameter("type");
		String amount=request.getParameter("amount");
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		CartVO vo=new CartVO();
		vo.setGoods_no(Integer.parseInt(goods_no));
		vo.setType(Integer.parseInt(type));
		vo.setAmount(Integer.parseInt(amount));
		vo.setPrice(Integer.parseInt(price));
		vo.setId(id);
		
		CartDAO dao=CartDAO.newInstance();
		dao.cartInsert(vo);
		
		return "redirect:../goods/goods_detail.do?no="+goods_no+"&type="+type;
	}
	
	@RequestMapping("cart/cart_buy.do")
	public void cart_buy(HttpServletRequest request,HttpServletResponse response) {
		String no=request.getParameter("cart_no");
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		CartDAO dao=CartDAO.newInstance();
		List<CartVO> list=dao.mypageBuyCartListData(id);
	}
	
}
