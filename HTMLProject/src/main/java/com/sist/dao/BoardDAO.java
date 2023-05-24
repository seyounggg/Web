package com.sist.dao;
// 오라클만 연결 => SELECT, UPDATE, INSERT, DELETE
import java.util.*;
import java.sql.*;
public class BoardDAO {
	// 연결 객체
	private Connection conn;
	// 송수신 객체(오라클 (SQL문장 전송), 실행 결과값을 읽어온다)
	private PreparedStatement ps;
	// 모든 사용자가 1개의 DAO만 사용할 수 있게 만든다 (싱글턴)
	private static BoardDAO dao;
	// 오라클 연결 주소 => 상수형으로!
	private final String URL="jdbc:oracle:thin:@localhost:1521:xe";
	
	//1. 드라이버 등록
	public BoardDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception ex) {}
	}
	//2. 싱글턴 => new생성 => heap에서 계속 누적 => 오라클 연결되고 있다
	// 싱글턴은 메모리 누수, Connection객체 생성갯수를 제한할 때 주로 사용한다
	// 한개의 메모리만 사용이 가능하게 만든다
	// 서버프로그램, 데이터베이스 프로그램에서 주로 사용한다
	// *** Spring은 모든 객체가 싱글턴~
	public static BoardDAO newInstance() {
		if(dao==null)
			dao=new BoardDAO();
		return dao;
	}
	//3. 오라클 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
			// conn hr/happy => 오라클 연결
		}catch(Exception ex) {}
	}
	//4. 오라클 해제
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch(Exception ex) {}
	}
	//--------------------------------필수 과정 ====> 클래스화(라이브러리)
	//5. 기능
	//5-1. 목록출력 => 페이지 나누기(인라인뷰) : SELECT
	// => 1page => 10개 출력
	// => BoardVO (게시물 1개를 모아둔것) -> 10개 모아야 하니까 List를 사용한다
	// 상세보기는 1개만 보여주면 되니까 그냥 BoardVO만 사용
	public List<BoardVO> boardListData(int page){
		List<BoardVO> list=new ArrayList<BoardVO>();
		try {
			//1.연결
			getConnection();
			//2.SQL문장 생성
			String sql="SELECT no,subject,name,TO_CHAR(regdate,'YYYY-MM-DD'),hit,num "
					+ "FROM (SELECT no,subject,name,regdate,hit,rownum as num "
					+ "FROM (SELECT no,subject,name,regdate,hit "
					+ "FROM freeboard ORDER BY no DESC)) "
					+ "WHERE num BETWEEN ? AND ?";
			//rownum은 중간에서 데이터를 추출할 수 없다 -> num으로 번호를 고정
			//3.SQL문장 전송
			ps=conn.prepareStatement(sql);
			//4.사용자가 요청한 데이터를 첨부
			//4-1. 물음표에 값 채워주기
			int rowSize=10;
			int start=(page*rowSize)-(rowSize-1); //(page-1)*rowSize
			/*
			 * 1page   1 ~ 10
			 * 2page   11 ~ 20
			 * 3page   21 ~ 30
			 */
			int end=page*rowSize;
			ps.setInt(1, start);
			ps.setInt(2, end);
			//5.실행 요청 후 결과값 받는다
			ResultSet rs=ps.executeQuery(); 
			//6.받은 결과값을 list에 첨부
			while(rs.next()) {
				BoardVO vo=new BoardVO();
				vo.setNo(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setDbday(rs.getString(4));
				vo.setHit(rs.getInt(5));
				list.add(vo);
			}
		}catch(Exception ex) {
			ex.printStackTrace(); //에러확인
		}finally {
			disConnection(); //오라클 연결해제
		}
		return list;
	}
	//5-1-1. 총페이지 구하기
	public int boardTotalPage() {
		int total=0;
		try {
			getConnection(); // 계속 반복 -> 메소드!!
			// sql문장 제작
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM freeboard";
			//43/10.0 => 4.3 => 5
			ps=conn.prepareStatement(sql);
			//실행요청
			ResultSet rs=ps.executeQuery();
			rs.next(); // 값이 출력되어 있는 위치에 커서를 이동
			total=rs.getInt(1);
			rs.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			disConnection();
		}
		return total;
	}
	//5-2. 상세보기 => 조회수 증가(UPDATE), 상세볼 게시물 읽기(SELECT)
	//5-3. 게시물 등록 => INSERT
	//5-4. 수정(UPDATE) => 먼저 입력한 게시물 읽기, 실제 수정(비밀번호 검색)
	//5-5. 삭제(DELETE) => 비밀번호 검색
	//5-6. 검색(이름, 제목, 내용) => LIKE
}
