<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.sist.dao.*"%>
<%-- 283page
	DBCP => DataBaseConnectionPool
	1. 연결 / 해제 반복
		=> 시간 소모가 많다(오라클 연결시에 시간이 많이 소모된다)
			------ 연결 시 시간소모를 절약 (DBCP)
		=> 미리 Connection객체를 생성해서 저장 후에 사용
		=> 일반적으로 웹프로그램에서는 일반화
		=> Connection객체 생성을 제한
		=> 사용후에는 재사용이 가능
	2. Connection을 미리 생성하기 떄문에 => Connection객체 관리가 쉽다
	3. 서버가 쉽게 다운되지 않는다
	4. 라이브러리가 만들어져 있다(commons-dbcp,commoms-pool)
	
	ConnectionPool (280page)
	목적 : 사용자의 응답을 빠르게 제공하기 위해 => 효율적으로 데이터 베이스 연결!!
	
	DBCP
	1. 방법
		1) Connection 객체 생성(maxActive:최대,maxIdle:풀)
		2) POOL영역에 저장
		3) 사용자가 요청시에 Conncetion의 주소를 얻어온다
		4) 사용자 요청에 따라 수행
		5) 반드시 POOL안에 Connection객체를 반환
	1-1. 쉽게 만드는 방법
		1) server.xml => Connection객체 생성
		2) 코딩 방법
			- getConnection() : 미리 생성된 Connection객체를 얻기
			- disConnection() : 반환
			- 기능 => 이전하고 동일하다
			** 보안이 좋다
 --%>
<%
	//1. 사용자가 전송한 데이터를 받는다(page)
	String strPage=request.getParameter("page");
	//2. 실행과 동시에 페이지 전송이 불가능하다 => 첫페이지는 default 속성(1)
	if(strPage==null)
		strPage="1";
	//3. 현재페이지 지정
	int curpage=Integer.parseInt(strPage);
	//4. 현재페이지에 대한 데이터 읽기(DAO=>오라클)
	FoodDAO dao=FoodDAO.newInstance();
	List<FoodBean> list=dao.foodListData(curpage);
	//5. 총페이지 읽기
	 int totalpage=dao.foodTotalPage();
	//6. 블록별 처리
	final int BLOCK=10;
	// [0] ~ [10] , [11] ~ 120]
	//7. 시작위치
	/*
		curpage 1~10 startPage=1
	*/
	int startPage=((curpage-1)/BLOCK*BLOCK)+1; // 1 11 21 ...
	//8 끝 페이지
	int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK; // 10 20 30 ...
	if(endPage>totalpage){
		endPage=totalpage;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
  .continer{
  	margin-top: 50px;
  }
  .row{
  	margin: 0px auto;
  	width: 960px;
  }
  </style>
</head>
<body>
  <div class="container">
    <div class="row">
      <%
      	for(FoodBean vo:list){
      %>
      <div class="col-md-3">
		   <div class="thumbnail">
			    <a href="#">
			      <img src="<%=vo.getPoster() %>"  style="width:100%">
			      <div class="caption">
			        <p><%=vo.getName() %></p>
			      </div>
			    </a>
			</div>
		</div>
      <%
      	}
      %>
    </div>
  </div>
</body>
</html>