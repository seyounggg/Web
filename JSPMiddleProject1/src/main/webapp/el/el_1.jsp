<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	MVC (Model View Controller)
	EL은 MVC 구조에서 주로 뷰(View)에서 사용되는 표현언어다.
		JSP와 같은 웹 애플리케이션 개발에서 주로 사용 => JSP에서 데이터를 동적으로 표현하고 조작이 가능
	
	EL (Expression Language) : 표현식
		${출력물} => <%= %>
		------- 변수를 출력하는 것이 아니다
		request에 있는 값, session, application, param
	=> 연산자
		이항연산자
		
		산술연산자 (+ , - , * , / , %)
			+ : 산술만 처리(문자열 결합은 안된다 : +=)
			/ : 정수/정수 => 실수 , 0으로 나눌 수 없다
				형식이 다양하다 => (div) ${10 div 2} , ${10/2}
			% : 나누고 나머지 값
				형식) ${10 mod 2} , ${10%2}
			*** null값은 0으로 취급
			*** "1" => 자동으로 Integer.parseInt() => 정수로 형변환
		비교연산자 (== , != , < , > , <= , > =)
			문자열이나 날짜 비교시에 동일하게 사용한다
			예) "홍길동" == ""
				-> 한글의 경우 ㄱ<ㄴ<ㄷ<ㄹ.. 순서로/알파벳은 A<B<C<D...
			== : (eq)   ${10 eq 10} == ${10 == 10)
			!= : (ne)
			<  : (lt)
			>  : (gt)
			<= : (le)
			>- : (ge)
			
		논리연산자 (&& ||)
			&& = and : 범위 포함
			|| = or : 범위 벗어난 경우
			!  = not
		삼항연산자 : 페이지, select, radio...
			형식)
				${조건?"값":"값"}
				${sex=='남자'?"checke":""}	
		기타연산자
			Empty : null, 공백인 경우 처리 => 사용빈도는 거의 없다
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>산술연산자</h1>
<%--
&#36;{10+10}=${10+10 }<br>
&#36;{"10"+10}=${"10"+10 }<br>"숫자" => Integer.parseInt()
&#36;{"10"+10}=${"10"+=10 }<br> "+= : 문자열 결합
--%>
<%-- 정수/정수 --%>
<%--
&#36;{10/3}=${10/3}<br>
&#36;{10 div 3}=${10 div 3}<br>
&#36;{10%3}=${10%3}<br>
&#36;{10 mod 3}=${10 mod 3}<br>
--%>
<%-- null값은 0으로 인식
&#36;{null+10}=${null+10} --%>
<%-- 비교연산자
&#36;{"홍길동"=="심청이"}=${"홍길동"=="심청이"}<br>
			${"홍길동" eq "심청이"}
&#36;{"홍길동"!="심청이"}=${"홍길동"!="심청이"}<br>
			${"홍길동" nq "심청이"}
&#36;{"홍길동"<"심청이"}=${"홍길동"<"심청이"}<br>
			${"홍길동" lt "심청이"}
&#36;{"홍길동">"심청이"}=${"홍길동">"심청이"}<br>
			${"홍길동" gt "심청이"}
&#36;{"홍길동"<="심청이"}=${"홍길동"<="심청이"}<br>
			${"홍길동" le "심청이"}
&#36;{"홍길동">="심청이"}=${"홍길동">="심청이"}<br>
			${"홍길동" ge "심청이"}
--%>
<%-- 논리연산자 (조건) 논리 연산 (조건)
&#36;{10>6 && 5==6}=${10>6 && 5==6}<br>
&#36;{10>6 || 5==6}=${10>6 || 5==6}<br>
--%>
</body>
</html>