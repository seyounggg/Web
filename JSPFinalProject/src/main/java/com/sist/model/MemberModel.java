package com.sist.model;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.MemberDAO;
import com.sist.vo.MemberVO;
import com.sist.vo.ZipcodeVO;

public class MemberModel {
	
	@RequestMapping("member/join.do")
	public String memberJoin(HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("main_jsp","../member/join.jsp"); //Home화면을 변경
		CommonModel.commonRequestData(request);
		return "../main/main.jsp"; //화면출력
	}
	@RequestMapping("member/idcheck.do")
	public String memberJoinIdCheck(HttpServletRequest request,HttpServletResponse response) {
		
		return "../member/idcheck.jsp"; //화면출력
	}
	
	@RequestMapping("member/idcheck_ok.do")
	public void memberIdCheckOk(HttpServletRequest request,HttpServletResponse response) {
		String id=request.getParameter("id");
		MemberDAO dao=MemberDAO.newInstance();
		int count=dao.memberIdCheck(id);
		// 데이터를 Ajax로 전송 ==> success:function(result)
		try {
			PrintWriter out=response.getWriter();
			out.println(count);
		} catch (Exception e) {}
	}
	
	@RequestMapping("member/postfind.do")
	public String memberPostFind(HttpServletRequest request,HttpServletResponse response) {
		
		return "../member/postfind.jsp"; //화면출력
	}
	
	@RequestMapping("member/postfind_result.do")
	public String memberPostFindResult(HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String dong=request.getParameter("dong");
		MemberDAO dao=MemberDAO.newInstance();
		int count=dao.postFindCount(dong);
		List<ZipcodeVO> list=dao.postFindData(dong);
		//------------------------------------------ 결과값 가져와서
		
		//---------------------------------- request로 값 넣기
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		return "../member/postfind_result.jsp";
	}
	
	@RequestMapping("member/join_ok.do")
	public String memberJoinOk(HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		String name=request.getParameter("name");
		String sex=request.getParameter("sex");
		String birthday=request.getParameter("birthday");
		String email=request.getParameter("email");
		String post=request.getParameter("post");
		String addr1=request.getParameter("addr1");
		String addr2=request.getParameter("addr2");
		String phone1=request.getParameter("phone1");
		String phone=request.getParameter("phone");
		String content=request.getParameter("content");
		
		MemberVO vo=new MemberVO();
		vo.setId(id);
		vo.setPwd(pwd);
		vo.setName(name);
		vo.setSex(sex);
		vo.setBirthday(birthday);
		vo.setEmail(email);
		vo.setPost(post);
		vo.setAddr1(addr1);
		vo.setAddr2(addr2);
		vo.setPhone(phone1+"-"+phone);
		vo.setContent(content);
		
		MemberDAO dao=MemberDAO.newInstance();
		dao.memberInsert(vo);
		
		// 이동
		return "redirect:../main/main.do"; //main.jsp안되고, main.do를 출력해서 home으로 바로 가게 해야한다
		// 모델을 거쳐서 데이터를 받아와야 하기 떄문에 .do를 호출해야한다 (jsp는 화면)
	}
	
	@RequestMapping("member/login.do")
	public void memberLogin(HttpServletRequest request,HttpServletResponse response) {
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		MemberDAO dao=MemberDAO.newInstance();
		MemberVO vo=dao.memberLogin(id, pwd);
		HttpSession session=request.getSession();
		// 로그인이 되면 => 사용자의 정보 일부를 세션에 저장
		if(vo.getMsg().equals("OK")) { // => 로그인된 상태
			session.setAttribute("id", vo.getId());
			session.setAttribute("name", vo.getName());
			session.setAttribute("sex", vo.getSex());
			session.setAttribute("admin", vo.getAdmin());
			// session은 전역변수 => 모돈 JSP에서 사용이 가능
		}
		// session에 저장한 결과값을 전송 => Ajax
		try {
			PrintWriter out=response.getWriter();
			// 사용자 브라우저로 읽어가는 메모리 공간
			out.println(vo.getMsg()); //NOID,NOPWD,OK
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	/*
			<%@ page~~ %>
			<% 
				~~~~~
			%>
	 */
	@RequestMapping("member/logout.do")
	public String memberLogout(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session=request.getSession();
		session.invalidate();
			
		return "redirect:../main/main.do";
	}
}
