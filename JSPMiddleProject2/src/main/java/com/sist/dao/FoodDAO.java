package com.sist.dao;

import java.sql.*;
import java.util.*;
// DBCP
import javax.sql.*;
import javax.naming.*;
public class FoodDAO {
	// 연결객체 얻기
	private Connection conn;
	// sql문장 송수신
	private PreparedStatement ps;
	// 싱글턴
	private static FoodDAO dao;
	// 출력갯수
	private final int ROW_SIZE=20;
	
	// Pool영역에서 Connection객체 얻어오기
	public void getConnection() {
		// Connection 객체주소를 메모리에 저장
		// 저장공간 -> POOL영역(디렉토리형식으로 저장) => JNDI
		// 루트 => 저장공간
		// java://env/comp => C드라이버 => jdbc/oracle
		
		try {
			//1.탐색기를 연다
			Context init=new InitialContext();
			//2. C드라이버 연결
			Context cdriver=(Context)init.lookup("java://comp//env");
			//                            ---------- 메소드 : 문자열(key) => 객체찾기(RMI)
			//3. Connection객체 찾기
			DataSource ds=(DataSource)cdriver.lookup("jdbc/oracle");
			//4. Connection객체 주소 연결
			conn=ds.getConnection();
			// 282page
			//=> 오라클 연결 시간을 줄인다
			//=> Connection 객체가 일정하게 생성 -> 관리
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	// Connection객체 사용 후 반환
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch(Exception e) {}
	}
	// 싱글턴객체
	public static FoodDAO newInstance() {
		if(dao==null)
			dao=new FoodDAO();
		return dao;
	}
	// 동일 => 오라클 연결후 SQL문장 실행
	public List<FoodBean> foodListData(int page){
		List<FoodBean> list=new ArrayList<FoodBean>();
		try {
			getConnection(); // Connection주소 얻어온다
			String sql="SELECT fno,poster,name,num "
					+ "FROM (SELECT fno,poster,name,rownum as num "
					+ "FROM (SELECT /*+INDEX_ASC(food_location fl_fno_pk) */fno,poster,name "
					+ "FROM food_location)) "
					+ "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			int rowSize=ROW_SIZE;
			int start=(rowSize*page)-(rowSize-1); //rownum은 1번부터 시작
			int end=rowSize*page;
			
			// ?에 값 채우기
			ps.setInt(1, start);
			ps.setInt(2, end);

			//실행 요청
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				FoodBean vo=new FoodBean();
				vo.setFno(rs.getInt(1));
				vo.setName(rs.getString(3));
				String poster=rs.getString(2);
				poster=poster.substring(0,poster.indexOf("^"));
				poster=poster.replace("#", "&");
				vo.setPoster(poster);
				
				//list에 20개 채운다
				list.add(vo);
			}
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection(); //반환
		}
		return list;
	}
	public int foodTotalPage() {
		int totalpage=0;
		try {
			getConnection();
			String sql="SELECT CEIL(COUNT(*)/"+ROW_SIZE+") "
					+ "FROM food_location";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			totalpage=rs.getInt(1);
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection(); // 사용 시 반드시 반환
		}
		return totalpage;
	}
	// 상세보기
	public FoodBean foodDetailData(int fno) {
		FoodBean vo=new FoodBean();
		try {
			getConnection(); //Connection주소 얻기

			String sql="SELECT fno,poster,name,tel,score,time,parking,type,price,menu,address "
					+ "FROM food_location "
					+ "WHERE fno=?";
			ps=conn.prepareStatement(sql); //String sql을 전송한다는 의미
			// 실행 전에 ?에 값을 채운다
			ps.setInt(1, fno);
			ResultSet rs=ps.executeQuery();
			// 데이터가 있는 메모리에 커서를 위치한다
			rs.next();
			vo.setFno(rs.getInt(1));
			vo.setPoster(rs.getString(2));
			vo.setName(rs.getString(3));
			vo.setTel(rs.getString(4));
			vo.setScore(rs.getDouble(5));
			vo.setTime(rs.getString(6));
			vo.setParking(rs.getString(7));
			vo.setType(rs.getString(8));
			vo.setPrice(rs.getString(9));
			vo.setMenu(rs.getString(10));
			vo.setAddress(rs.getString(11));
			rs.close();
			// 정수형 => rs.getInt() | 실수 => rs.getDouble() | 날짜 => rs.getDate() | 문자열 => rs.getString()
			// BLOB , BFILE, => rs.getInputStream()
		}catch (Exception e) {
			e.printStackTrace(); //에러 확인
		}finally{
			disConnection(); //반환 => Connection
		}
		return vo;
	}
}
