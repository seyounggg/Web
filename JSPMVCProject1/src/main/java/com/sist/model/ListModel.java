package com.sist.model;

import javax.servlet.http.HttpServletRequest;
/*
	사용자 요청 =====> Controller =====> Model을 찾는다
						|				|
				request,session 전송받기	요청처리
						|				-----
					jsp 찾기				결과를 request, session에 담는다
						|									=> Controller로 
				jsp에 request,session 전송
 */
public class ListModel {
	public String execute(HttpServletRequest request) {
		request.setAttribute("msg", "목록보기");
		return "list.jsp";
	}
}
