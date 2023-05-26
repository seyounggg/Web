package com.sist.servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sist.dao.*;

@WebServlet("/BoradUpdateServlet")
public class BoradUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 입력폼 전송 => HTML (의미 : HTML을 브라우저로 보낸다)
		response.setContentType("text/html;charset=UTF-8");
		
		String no=request.getParameter("no");
		BoardDAO dao=BoardDAO.newInstance();
		BoardVO vo=dao.boardUpdate(Integer.parseInt(no));
		
		// 메모리에 HTML을 저장 => 브라우저에서 읽어서 출력
		PrintWriter out=response.getWriter(); // 브라우저에서 읽어가렴
	   
		
		out.println("<html>");
		out.println("<head>");
		out.println("<link rel=stylesheet href=html/table.css>");
		out.println("</head>");
		out.println("<body>");
		out.println("<center>");
		out.println("<h1>수정하기</h1>");
		out.println("<form method=post action=BoradUpdateServlet>");
		// method를 보내서 전송할때 방식이 post 이면 => doPost()!!  
		// 입력된 데이터를 한번에 => action에 등록된 class로 전송
		out.println("<table class=table_content width=700>");
		out.println("<tr>");
		out.println("<th width=15%>이름</th>");
		out.println("<td width=85%><input type=text name=name size=15 required value=\""+vo.getName()+"\"></td>"); // required : 반드시 입력값이 있어야 한다(not null)
		out.println("</tr>");
		out.println("<tr>");
		out.println("<th width=15%>제목</th>");
		out.println("<td width=85%><input type=text name=subject size=50 required value=\""+vo.getSubject()+"\"></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<th width=15%>내용</th>");
		out.println("<td width=85%><textarea rows=10 cols=50 name=content required>"+vo.getContent()+"</textarea></td>"); // textarea는 반드시 열고/ 닫고!!
		out.println("</tr>");
		out.println("<tr>");
		out.println("<th width=15%>비밀번호</th>");
		out.println("<td width=85%><input type=password name=pwd size=15 required>");
		out.println("<input type=hidden name=no value="+no+">");
		// 사용자에게 보여주면 안되는 데이터 -> 화면출력 없이 데이터 전송할 수 있게!! -> hidden
		out.println("</td></tr>");
		out.println("<tr>");
		out.println("<td colspan=2 align=center>");
		out.println("<input type=submit value=수정하기>");
		out.println("<input type=button value=취소 onclick=\"javascript:history.back()\">");
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</form>");
		out.println("</center>");
		out.println("</body>");
		out.println("</html>");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String no=request.getParameter("no");
		String pwd=request.getParameter("pwd");
		
		PrintWriter out=response.getWriter();
		BoardDAO dao=BoardDAO.newInstance();
		boolean bCheck=dao.boardUpdate(Integer.parseInt(no), pwd);
		// 수정하기 -> 상세보기창으로 이동
		if(bCheck==true) {
			// 목록으로 이동
			response.sendRedirect("BoardListServlet?no="+no);
		}else {
			// 삭제창으로 이동
			out.println("<script>");
			out.println("alert(\"비밀번호가 틀립니다!\");");
			out.println("history.back();");
			out.println("</script>");
		}
		try {
			request.setCharacterEncoding("UTF-8"); //한글변환
			// 디코딩 => byte[]을 한글로 변환
			// 자바 => 2byte => 브라우저는 1byte로 받는다 => 2byte
		}catch(Exception ex) {}
		String name=request.getParameter("name");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		
		/*System.out.println("이름:"+name);
		System.out.println("제목:"+subject);
		System.out.println("내용:"+content);
		System.out.println("비밀번호:"+pwd);*/
		BoardVO vo=new BoardVO();
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setPwd(pwd);
		
		//오라클로 UPDATE 요청
		//?????
		
		// 화면이동
		response.sendRedirect("BoardListServlet");
	}

}
