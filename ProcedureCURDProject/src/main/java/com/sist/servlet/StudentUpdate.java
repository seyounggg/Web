package com.sist.servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sist.dao.*;
@WebServlet("/StudentUpdate")
public class StudentUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		//사용자가 보내준 값 받기
		String hakbun=request.getParameter("hakbun");
		StudentDAO dao=StudentDAO.newInstance();
		StudentVO vo=dao.studentDetail(Integer.parseInt(hakbun));
		
		out.println("<html>");
		out.println("<head>");
		out.println("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css\">");
		out.println("<style>");
		out.println(".container{margin-top:50px}");
		out.println(".row{margin:0px auto; width:350px}");
		out.println("h1{text-align:center}");
		out.println("</style>");
		out.println("</head>");
		out.println("<body>");
		out.println("<div class=container>");
		out.println("<h1>학생 수정</h1>");
		out.println("<div class=row>");
		out.println("<form method=post action=StudentUpdate>");
		
		out.println("<table class=table>");
		out.println("<tr>");
		out.println("<td width=35%>이름</td>");
		out.println("<td width=65%>");
		out.println("<input type=hidden name=hakbun value="+hakbun+">"); // 출력하지 않고 데이터만 전송할 목적(hidden!!) > 번호, 페이지 => 사용자 중심으로 초점!
		out.println("<input type=text name=name size=20 class=input-sm value="+vo.getName()+">");
		out.println("</td>");
		out.println("</tr>");
		
		out.println("<tr>");
		out.println("<td width=35%>국어</td>");
		out.println("<td width=65%>");
		out.println("<input type=number name=kor size=20 class=input-sm max=100 min=0 step=5 value="+vo.getKor()+">"); // step은 5단위씩 위아래 화살표로 값 변경 , value에 50을 넣어서 default값을 지정
		out.println("</td>");
		out.println("</tr>");
		
		out.println("<tr>");
		out.println("<td width=35%>영어</td>");
		out.println("<td width=65%>");
		out.println("<input type=number name=eng size=20 class=input-sm max=100 min=0 step=5 value="+vo.getEng()+">");
		out.println("</td>");
		out.println("</tr>");
		
		out.println("<tr>");
		out.println("<td width=35%>수학</td>");
		out.println("<td width=65%>");
		out.println("<input type=number name=math size=20 class=input-sm max=100 min=0 step=5 value="+vo.getMath()+">");
		out.println("</td>");
		out.println("</tr>");
		
		out.println("<tr>");
		out.println("<td colspan=2 class=text-center>");
		out.println("<input type=submit value=수정 class=\"btn btn-sm btn-warning\">");
		out.println("<input type=button value=취소 class=\"btn btn-sm btn-warning\" onclick=\"javascript:history.back()\">"); // onclick=\"javascript:history.back()\" <- 이전화면으로 전환
		out.println("</td>");
		out.println("</tr>");
		
		out.println("</table>");
		out.println("</form>"); // 호출 => submit버튼 클릭 시
		out.println("</div>"); //div class=row
		out.println("</div>"); //div class=container
		out.println("</body>");
		out.println("</html>");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글 => 디코딩
				request.setCharacterEncoding("UTF-8");
				// 사용자가 보내준 값을 받는다
				// <input type=text name=name> => name속성을 설정하지 않으면 null값을 출력한다
				// name속성은 servlet에서만 적용되는 것이 아니라 jsp/spring 에서도 똑같이 적용된다
				//                                         ------> servlet 으로 만들어져 있다
				String name=request.getParameter("name");
				String kor=request.getParameter("kor");
				String eng=request.getParameter("eng");
				String math=request.getParameter("math");
				String hakbun=request.getParameter("hakbun");
				// public String insert(StudentVO vo) <- Spring 코드!
				
				StudentVO vo=new StudentVO();
				vo.setName(name);
				vo.setKor(Integer.parseInt(kor));
				vo.setEng(Integer.parseInt(eng));
				vo.setMath(Integer.parseInt(math));
				vo.setHakbun(Integer.parseInt(hakbun));
				
				StudentDAO dao=StudentDAO.newInstance();
				dao.studentUpdate(vo);
				
				// 이동
				response.sendRedirect("StudentList");
	}

}
