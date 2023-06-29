package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sist.dao.*;
public class FoodDetailModel implements Model {

	@Override
	public String handlerRequest(HttpServletRequest request, HttpServletResponse respnose) {
		//사용자가 보내준 값 받기(food_list에서 fno번호를 넘김)	
		FoodDAO dao=FoodDAO.newInstance();
		String fno=request.getParameter("fno");
		FoodVO vo=dao.foodDetailData(Integer.parseInt(fno));
		String address=vo.getAddress();
		String addr1=address.substring(0,address.lastIndexOf("지")); 
		String addr2=address.substring(address.lastIndexOf("지")+3);
		String temp=addr1.trim().substring(addr1.indexOf(" ")+1);
		String addr3=temp.substring(0,temp.indexOf(" "));
		
		request.setAttribute("vo",vo);
		request.setAttribute("addr1", addr1);
		request.setAttribute("addr2", addr2);
		request.setAttribute("addr3", addr3);
		return "food/food_detail.jsp";
	}

}
