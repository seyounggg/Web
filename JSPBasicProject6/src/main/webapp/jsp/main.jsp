<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.sist.dao.*"%>
<%
	// 출력할 데이터 읽기(오라클)
	// 1. 사용자 요청
	String strPage=request.getParameter("page");
	// => 첫 페이지 : default로 설정
	if(strPage==null)
		strPage="1";
	// 2. DAO 연결 => 데이터 읽기 (출력할 내용 다가지고 온다!!)
	int curpage=Integer.parseInt(strPage);
	FoodDAO dao=FoodDAO.newInstance();
	List<FoodBean> list=dao.foodListData(curpage);
	int totalpage=dao.foodTotalPage();
	// 3. 읽은 데이터 출력 => HTML
	
	// 쿠키 읽기
	Cookie[] cookies=request.getCookies();
	List<FoodBean> cList=new ArrayList<FoodBean>();
	if(cookies!=null){ //쿠키가 존재하면
		for(int i=cookies.length-1;i>=0;i--){ //최신부터 읽는 조건식
			if(cookies[i].getName().startsWith("food_")){
				// 쿠키에 food_ 뿐만 아니라 다른 쿠키id도 존재하기 때문에 food_로 시작하는 id만 가져오려는 조건식
				String fno=cookies[i].getValue();
				FoodBean vo=dao.foodDetailData(Integer.parseInt(fno));
				cList.add(vo);
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
  .container{
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
      <%-- 맛집 목록 출력 --%>
      <%
      	for(FoodBean vo:list){
      %>
      	<div class="col-md-3">
		   <div class="thumbnail">
			    <a href="detail_before.jsp?fno=<%=vo.getFno()%>">
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
    <div style="height: 20px"></div>
    <div class="row">
      <%-- 맛집 페이지 출력 --%>
      <div class="text-center">
        <a href="main.jsp?page=<%=curpage>1?curpage-1:curpage %>" class="btn btn-sm btn-danger">이전</a>
        <%=curpage %>page / <%=totalpage %> pages
        <a href="main.jsp?page=<%=curpage<totalpage?curpage+1:curpage %>" class="btn btn-sm btn-primary">다음</a>
      </div>
    </div>
    <div style="height: 20px"></div>
    <h3>최신 방문 맛집</h3>
    <a href="all_delete.jsp" class="btn btn-xs btn-warning">전체 삭제</a>
    <a href="all_cookie.jsp" class="btn btn-xs btn-warning">더보기</a>
    <hr>
    <div class="row">
      <%-- 최근 방문 --%>
      <%
      	int i=0;
      	if(cookies!=null && cList.size()>0){
      %>
      <table class="table">
        <tr>
      <%
      		for(FoodBean vo:cList){
      			if(i>9) break;
      %>
      		<td>
      		<img src="<%=vo.getPoster() %>" style="width: 100px;height: 100px" title="<%=vo.getName() %>">
      		<br>
      		<a href="cookie_delete.jsp?fno=<%=vo.getFno() %>" class="btn btn-sm btn-danger">삭제</a>
      		</td>
      
      <%
      			i++;
      		}
      %>
        </tr>
      </table>	
      <%
      	} else {
      %>
      		<h3>쿠키가 없습니다</h3>
      <%	
      	}
      %>
    </div>
  </div>
</body>
</html>