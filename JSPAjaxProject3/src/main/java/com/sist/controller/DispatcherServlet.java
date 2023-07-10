package com.sist.controller;

import java.io.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// Spring의 MVC 구조
/*
	화면단(View단) : JSP => EL/JSTL
		=> View
	구현단(비지니스 로직) : Java => 데이터베이스 연결(요청 처리)
		=> Model (VO, DAO, Model, Manager)
	연결 (화면, 구현) : Servlet
		=> Controller
	-------------------------------------------------
	model1 (순수하게 JSP) 
		장점 : 분석하기 편하다
		단점 : 확장성이 떨어지고, 추가 및 재사용이 어렵다
	model2 (JSP/Java)
		장점 : 여러명이 동시에 개발이 가능하다
			(추가,재사용,확장성이 용이하다 => 유지보수)
		단점 : 나눠서 코딩을 해야하므로 복잡하다
	domain : Controller를 나눠서 작업한다(기존:Controller에 집중)
		장점 : 기능별 서버를 나눠서 독립적으로 개발
		MSA => Spring-Cloud
		------------------- CI/CD(git기반, 도커, 쿠바네티스,젠킨스)
		DevOps (개발/운영)
	
	MVC의 동작구조
	** Controller 찾는 방법 : .do (URL주소 설정)
			  *.do(* : 모든 단어)
	사용자 요청 ------------------ Controller(DispatcherServlet) ----- Model ----- DAO
									(FrontController)
											|
								=> 저장된 Model클래스를 찾는 역할
								=> 요청처리에 대한 메소드를 찾아서 호출한다
								=> 결과값을 request에 담아서 JSP로 전송
								=> Spring : DispatcherServlet
								=> Struts : FilterDispatcher
								=> 이미 만들어진 메소드를 호출(재호출) : redirect
								=> 새로운 데이터를 JSP로 전송 : forward
								=> 어노테이션 : if를 대체 / 인덱스(찾기기능)
	
	Model1방식 : JSP => JSP (홈페이지, 소기업 : 유지보수가 없는 경우)
	MV구조 : JSP => Java => JSP
	Model2방식 : JSP => Servlet => Java => Servlet => Java (유지보수/대규모)
 */
@WebServlet("*.do")
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void init(ServletConfig config) throws ServletException {
		
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
