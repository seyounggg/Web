package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InsertModel implements Model {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("msg", "추가기능!!");
		return "view/insert.jsp";
	}

}
