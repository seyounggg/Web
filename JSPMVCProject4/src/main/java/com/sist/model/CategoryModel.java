package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import com.sist.dao.*;
//			request	 request
// Controller => Model => JSP
/*
	class A {
		int aa;
	}
	public void set(A a) {
		a.aa=100;
	}
	A b=new A();
	set(b); => 100
	
	int c=100;
	aaa(c)
	public void aaa(int a)
	// 클래스가 넘어가면 클래스주소가 넘어가는거니까 해당 클래스에 값을 채우고 넘긴다!
 */
public class CategoryModel implements Model {

	@Override
	public String handlerRequest(HttpServletRequest request, HttpServletResponse respnose) {
		//System.out.println("CategoryModel:"+request);
		FoodDAO dao=FoodDAO.newInstance(); //객체생성
		List<CategoryVO> list=dao.foodCategoryData();
		// JSP에서 <% 요기 %> 요기 첫줄에 나오는 거!(데이터를 가져와야 하니까)
		
		//request : DispatcherServlet이 갖고 있는거임
		// DispatcherServlet이 갖고 있는 request에 값을 채워서 DispatcherServlet으로 넘김 -> 그 request를 JSP에 전송 -> 출력
		request.setAttribute("list", list);
		return "food/category.jsp";
	}

}
