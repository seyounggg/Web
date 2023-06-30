package com.sist.controller;

import java.io.*;
import java.lang.reflect.Method;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/*
	MVC 동작 과정
	1. 요청(JSP) => DispatcherServlet을 찾는다
		list.do				|
		insert.do			|
					서버에서 받을 수 있는 부분 URI,URL
					URI를 통해서 Model을 찾는다
	2. DispatcherServlet(Controller)
		=> FrontController
			: 사용자 요청을 받아서 Model을 연결해주고 데이터를 가져와서 request를 전송
							----- 요청 처리 기능을 갖고 있다
	3. MVC 목적
		1) 보안				***JSP는 배포 시 소스를 통쨰로 넘겨줘야 하므로 보안에 취약함
		2) 역할 분담(front/back)
		3) Java와 HTML을 분리하는 이유
			확장성, 재사용, 변경이 쉽다 (JSP는 한번 사용하면 버린다)
	4. 동작 순서
						.do							request
		JSP(링크,버튼) ---------- DispatcherServlet ---------- Model(DAO <==> 오라클)
															결과값을 request에 담아준다
															request.setAttribute()
				JSP ---------- DispatcherServlet ----------
				 |	request							request를 넘겨준다
				request.getAttribute() => ${}
	5. DispatcherServlet 은 최대한 고정
	6. 등록(Model클래스) => XML로 세팅 (메뉴판_메뉴판에 있는 것들을 찾아서 전송한다.)
	7. 메소드 찾기 => 어노테이션(메소드를 자동 호출 가능하게 한다)
	-----------------------------------------------
	어렵 : 맥 / 윈도우 호환 코딩
*/
import java.net.*;
import java.util.*;
@WebServlet("*.do")
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<String> clsList=new ArrayList<String>();
	// 초기화 => XML에 등록된 클래스 읽기(메뉴)
	public void init(ServletConfig config) throws ServletException {
		try {
			URL url=this.getClass().getClassLoader().getResource("."); // Realpath가 현재 폴더
			File file=new File(url.toURI());
//			System.out.println(file.getPath());
			String path=file.getParent();
			path=path.substring(0,path.lastIndexOf(File.separator));
			System.out.println(path);
			path=path+File.separator+"application.xml";
			
			//XML 파싱
			DocumentBuilderFactory dbf=DocumentBuilderFactory.newInstance();
			//파서기 (XML => DocumentBuilder, HTMl => Jsoup)
			DocumentBuilder db=dbf.newDocumentBuilder();
			//파서
			Document doc=db.parse(new File(path));
			// 필요한 데이터 읽기
			// root태그 => beans
			Element beans=doc.getDocumentElement();
			System.out.println(beans.getTagName());
			
			// 같은 태그를 묶어서 사용
			NodeList list=beans.getElementsByTagName("bean");
			for(int i=0;i<list.getLength();i++) {
				//bean 태그를 1개씩 가지고 온다
				Element bean=(Element)list.item(i);
				String id=bean.getAttribute("id");
				String cls=bean.getAttribute("class");
				System.out.println(id+":"+cls);
				clsList.add(cls);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 웹에서 사용자 요청 => servlet / jsp
	// servlet : 화면출력은 하지 않고 , 연결을 해주는 역할을 한다
	// jsp : 화면출력 (View)
	/*
		Controller : Servlet
			Spring : DispatcherServlet 
			Struts : ActionServlet
			Struts2 : FilerDispatcher
						   ---------- 배달부(request)
		Model : 요청처리 -> java
		View : 화면 출력 => jsp(HTML)
	 */
	// 요청에 따라 
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String path=request.getRequestURI();
			path=path.substring(request.getContextPath().length()+1);
			System.out.println(path); // Food/category.do => path출력결과
			// http://localhost/JSPMVCFinalProject/Food/category.do
			// /JSPMVCFinalProject/Food/category.do
			// Food/category.do => path출력결과
			
			for(String cls:clsList) {
				// Class정보 읽기 => 리플렉션
				Class clsName = Class.forName(cls);
				// 메모리 할당
				Object obj = clsName.getDeclaredConstructor().newInstance();
				Method[] methods=clsName.getDeclaredMethods(); //clsName에 선언되어 있는 모든 메소드를 가져와라(.getDeclaredMethods();)
				for(Method m:methods) {
					RequestMapping rm=m.getAnnotation(RequestMapping.class);
					if(rm.value().equals(path)) {
						String jsp=(String)m.invoke(obj, request, response);
						if(jsp==null) { //return형이 void일 경우에(Ajax)
							return;
						} else if(jsp.startsWith("redirect:")){
							//sendRedirect
							response.sendRedirect(jsp.substring(jsp.indexOf(":")+1));
						} else {
							RequestDispatcher rd=request.getRequestDispatcher(jsp);
							rd.forward(request, response);
						}
						return;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
