<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.sist.temp.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	
%>
<jsp:useBean id="bean" class="com.sist.temp.SawonBean">
  <jsp:setProperty name="bean" property="*"/>
</jsp:useBean>
<%-- 
	<jsp:useBean id="bean" class="com.sist.temp.SawonBean">
	메모리 할당 => SawonBean bean=new SawonBean(); 
	
	<jsp:setProperty name="bean" property="*"/>
	=> set메소드                   ----------- 전체 입력
	
	public void aaa(SawonBean bean)
	---------------------------------------------------------------------------
	218page 빈을 이용한 JSP 파일 작성
	---------------------------------------------------------------------------
	jsp 액션태그
	    ★화면 이동 : <jsp:forward>
		★화면 연결 : <jsp:include>
		★갑 전송 : <jsp:param>
		객체 생성 : <jsp:useBean>
		멤버변수 값 주입 : <jsp:setProperty>
		멤버변수 값 읽기 : <jsp:getProperty>
	---------------------------------------------------------------------------
	<jsp:useBean> : 객체 메모리 할당
	속성)
		id : 객체명
		class : 클래스명(사용 시 => 패키지명.클래스명 => class.forName())
		scope : 사용범위
		 = page(default) : 한개의 JSP에서만 사용(다른페이지로 이동 => 메모리 해제)
		 	=> 보통 page를 주로 사용하고/ 생략이 가능하다
		 = request : 사용자 요청이 있을 경우에 사용
		 = session : 프로그램이 유지하고 있는 동안 (접속 ~ 종료)
		 = application : 프로그램 종료시까지 유지
	형식)
		<jsp:useBean id="a" class="A"> ==> A a=new A();
	---------------------------------------------------------------------------
	<jsp:setProperty> : 변수에 값을 설정 (쓰기)
		=> setter 호출
		name : 객체명
		property : 변수
		value : 값 설정
		
		예)
		class A{
			private int no;
			private String name;
			
			setNo() getNo() setName() getName()
		}
		[메모리 할당]
		<jsp:useBean id="a" class="A">
		<jsp:setProperty name="a"(=> id와 같아야 한다) property="name" value="홍길동">  => 초기화
			  A    a=new A()
			 ---  ---
		    class id
		    a.setName("홍길동")
		    
		  # id와 name이 다르다는 것은
		    A a=new A();
		    b.setNo() <- 인것과 같다 ! 무조건 같아함.
	    <jsp:setProperty name="a" property="no" value="10">
	     	a.setNo(10)
	    <jsp:setProperty name="a" property="*"/>
	      	a.setName(request.getParameter("name"))
	      	a.setNo(Integer.parseInt(request.getParameter("no"))
		</jsp:useBean>
		
		class A에 있는 int no, String name 과
			<jsp:setProperty name="a" property="no" <- 변수명이 꼭 같아야 한다(다르면 오류)
	---------------------------------------------------------------------------
	<jsp:getProperty> : 변수 값을 읽어오기 (읽기)
		=> getter 호출
		<jsp:getProperty name="a" property="name"> => a.getName() 같다!
		<jsp:getProperty name="a" property="no"> => a.getNo()
	---------------------------------------------------------------------------
	useBean : 메모리 할당
	setProperty : setXxx()
	getProperty : getXxx()  와 같다!!
	=> 태그 자체가 라이브러리 => 자바코드로 변경이 된다
	*** <jsp: > <- 이거 자체가 라이브러리!
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  이름:<%=bean.getName() %><br>
  이름:<jsp:getProperty name="bean" property="name"/>
  성별:<%=bean.getSex() %><br>
  부서:<%=bean.getDept() %><br>
  직위:<%=bean.getJob() %><br>
  연봉:<%=bean.getPay() %><br>
</body>
</html>