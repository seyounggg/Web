package com.sist.model;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sist.controller.RequestMapping;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;
public class FoodModel {
	@RequestMapping("food/location_find.do")
	public String food_find(HttpServletRequest request,HttpServletResponse response) {
		//검색어를 받는다
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		
		String fd=request.getParameter("fd");
		if(fd==null) {
			fd="마포";
		}
		String page=request.getParameter("page");
		// jsp안에서는 page가 내장객체여서 변수명으로 사용할 수 없지만, 일반java에서는 사용 가능하다
		if(page==null) {
			page="1";
		}
		int curpage=(Integer.parseInt(page));
		// => DAO를 연결해서 값을 전송
		FoodDAO dao=FoodDAO.newInstance();
		List<FoodVO> list=dao.foodLocationFindData(fd, curpage);
		int totalpage=dao.foodLocationTotalPage(fd);
		
		final int BLOCK=10;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage)
			endPage=totalpage;
		
		// location_find.jsp로 전송할 데이터!!
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);
		request.setAttribute("fd", fd);
		request.setAttribute("main_jsp", "../food/location_find.jsp");
		return"../main/main.jsp";
	}
	/*
	 	MVC
	 	1. DAO 연결 => 오라클 연결 담당
	 	2. DAO , 브라우저(JSP) => 연결 => 결과값 => Model
	 	   --------------------------------
	 	3. 브라우저로 값을 전송 / 요청 => Controller (Front Controller)
	 		DispatcherServlet
	 	4. 전송받은 데이터 출력 : View(JSP)
	 					=> request, session
	 	
	 	동작과정
	 	1. 사용자가 요청 : <a> , <form>, ajax
	 		=> 지정된 URL을 사용(*.do)
	 	2-1. DispatcherServlet이 요청내용을 받는다
	 		=> service() (URI => .do추출)
	 	2-2. 요청 처리에 해당되는 메소드를 찾는다
	 		=> 어노테이션 (@RequestMapping)
	 			역할 : index (찾기기능)
	 			- 메소드 찾기 : @Target(METHOD)
	 			- 클래스 찾기 : Model만 찾는다
	 			- 생성자 찾기 
	 			- 매개변수 찾기
	 	2-3. 메소드를 찾아서 => 요청데이터를 Model로 전송
	 		=> m.invoke(obj,request,response)
	 		---------------------------------
	 			요청처리에 해당되는 메소드를 호출
	 			=> 메소드명은 자유롭게 만들 수 있다
	 			=> DI
	 	3. Model
	 		역할 : 요청처리 / 결과값 담기
	 		=> DAO(오라클) 연결 => 데이터 읽기
	 		=> request에 값을 담아주는 역할
	 	4. DispatcherServlet
	 		=> request에 담긴 데이터를 JSP로 전송
	 		=> requestDispatcher rd=request.getRequestDispatcher(jsp)
	 		   rd.forward(request,response)
	 		   ----------------------------
	 		   해당 JSP를 찾아서 request를 전송하는 역할!!
	 	5. JSP
	 		=> request에 담긴 데이터를 출력
	 		=> EL/JSTL
	 	-------------------------------------------------------------
	 	어노테이션 : 찾기 => if문이 추가된다
	 	------- 제어하는 것은 밑에 있는 class, method, 변수 또는 옆에 있는 것!! 
	 	
	 	@Controller => 메모리 할당 관련
	 	class A {
	 		@Autowired
	 		B b; => 자동으로 b의 주소값 대입
	 		
	 		@RequestMapping("food/list.do")
	 		public void disp(@Resource int a){
	 		}
	 	}
	 */
	@RequestMapping("food/food_category_list.do")
	public String food_list(HttpServletRequest request,HttpServletResponse response) {
		//					------------------------------------------------------
		//					=> DispatcherServlet => 매개변수로 전송 => 전송된 request에 값을 채운다
		// cno : 카테고리 번호를 넘겨준다
		String cno=request.getParameter("cno");
		// dao연결
		FoodDAO dao=FoodDAO.newInstance();
		CategoryVO cvo=dao.foodCategoryInfoData(Integer.parseInt(cno));
		List<FoodVO> list=dao.foodCategoryListData(Integer.parseInt(cno));
		
		// 출력할 jsp로 데이터 전송
		request.setAttribute("cvo", cvo);
		request.setAttribute("list", list);
		// 전송을 하면 return에 있는 jsp가 받는다
		// include 시에는 include된 모든 jsp에서 request값을 사용할 수 있다(request공유)
		// 예) include로 3개를 하나로 합쳐놨으니까 request를 공유할 수 있다
		request.setAttribute("main_jsp", "../food/food_category_list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("food/food_detail_before.do")
	public String food_detail_before(HttpServletRequest request,HttpServletResponse response) {
		// Cookie 생성
		String fno=request.getParameter("fno");
		Cookie cookie=new Cookie("food_"+fno, fno);
		// Cookie 단점 => 문자열만 저장할 수 있다 ...(요청한 사용자의 브라우저로 전송)
		// 쿠키 저장 위치 결정
		cookie.setPath("/");
		// 쿠키 저장 기간 설정
		cookie.setMaxAge(60*60*24); // 초단위로 계산(60*60*24 = 하루)
		// 쿠키 전송
		response.addCookie(cookie);
		return "redirect:../food/food_detail.do?fno="+fno;
	}
	/*
		회원가입 / 로그인 => main.do
		예약 / 장바구니 / 결제 => mypage.do
		
	 */
	@RequestMapping("food/food_detail.do")
	public String food_detail(HttpServletRequest request,HttpServletResponse response) {
		String fno=request.getParameter("fno");
		//dao연결
		FoodDAO dao=FoodDAO.newInstance();
		// 결과를 request에 담는다(setAttribute())
		FoodVO vo=dao.foodDetailData(Integer.parseInt(fno));
		request.setAttribute("vo", vo);
		
		String address=vo.getAddress();
		String addr1=address.substring(0,address.indexOf("지번"));
		String addr2=address.substring(address.indexOf("지번")+3);
		request.setAttribute("addr1", addr1.trim());
		request.setAttribute("addr2", addr2.trim());
		// 인근 명소 또는 레시피
		request.setAttribute("main_jsp", "../food/food_detail.jsp");
		return "../main/main.jsp";
	}
}
