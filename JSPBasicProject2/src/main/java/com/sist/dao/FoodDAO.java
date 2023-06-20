package com.sist.dao;
/*
	데이터 베이스 연동
	JDBC ====> DBCP ====> ORM(MyBatis,Hibernate) => JPA
				|				|					|
				1차				2차					3차
	JDBC 단점)
		- 요청시마다 연결하고 닫기를 반복해야한다
					-> 연결에 소요되는 시간이 오래 걸린다
		- Connection의 갯수를 관리할 수 없다
		- Connection이 많을 수록 서버가 다운될 가능성이 높다
	DBCP(DataBase Connection Pool)
		1. 미리 연결을 한다 / Connection갯수 지정
		2. 연결된 Connection을 얻어온다
		3. 반환 => 재사용
		4. WebProgram의 일반화
 */
import java.util.*;
import java.sql.*;
// 서버가 아니라 클라이언트 프로그램(실제서버 => 오라클)
public class FoodDAO {
	// 연결객체 => Socket
	private Connection conn;
	// 송수신 (SQL 문장 보내면 => 결과값(데이터값))
	private PreparedStatement ps;
	// URL
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	// Singleton
	private static FoodDAO dao;
	// static은 저장공간이 1개 이기 떄문에 static을 사용하면 자동으로 싱글턴이 되는거임
	// 쉽게 설명해서 변수 1개로 계속 사용한다고 생각하면 됨
	
	// 드라이버 등록
	public FoodDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception e) {}
	}
	// 오라클 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		}catch(Exception e) {}
	}
	// 오라클 해제
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch(Exception e) {}
	}
	// 싱글턴 처리
	public static FoodDAO newInstance() {
		if(dao==null)
			dao=new FoodDAO();
		return dao;
	}
	// 기능 수행
	public List<FoodVO> foodListData(){
		List<FoodVO> list=new ArrayList<FoodVO>();
		try {
			getConnection();
			// SQL문장
			String sql="SELECT fno,poster,name,rownum "
					+ "FROM food_location "
					+ "WHERE rownum<=20";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				FoodVO vo=new FoodVO();
				vo.setFno(rs.getInt(1));
				String poster=rs.getString(2);
				poster=poster.substring(0,poster.indexOf("^"));
				poster=poster.replace("#", "&");
				vo.setPoster(poster);
				vo.setName(rs.getString(3));
				list.add(vo);
			}
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
		return list;
	}
	// 상세보기 데이터 읽기
	public FoodVO foodDetailData(int fno) {
		FoodVO vo=new FoodVO();
		try {
			getConnection();
			String sql="SELECT fno,poster,name,score,tel,type,time,parking,price,menu,address "
					+ "FROM food_location "
					+ "WHERE fno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, fno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setFno(rs.getInt(1));
			vo.setPoster(rs.getString(2).replace("#", "&"));
			vo.setName(rs.getString(3));
			vo.setScore(rs.getDouble(4));
			vo.setTel(rs.getString(5));
			vo.setType(rs.getString(6));
			vo.setTime(rs.getString(7));
			vo.setParking(rs.getString(8));
			vo.setPrice(rs.getString(9));
			vo.setMenu(rs.getString(10));
			vo.setAddress(rs.getString(11));
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
		return vo;
	}
}