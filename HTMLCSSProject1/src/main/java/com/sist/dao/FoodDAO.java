package com.sist.dao;

import java.util.*;
import java.sql.*;
public class FoodDAO {
    // 연결 객체 
	private Connection conn;
	// 송수신 
	private PreparedStatement ps;
	// 오라클 URL주소 설정 
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	// 싱글턴 
	private static FoodDAO dao;
	// 1. 드라이버 등록 => 한번 수행 => 시작과 동시에 한번 수행 , 멤버변수 초기화 : 생성자 
	public FoodDAO()
	{
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// ClassNotFoundException => 체크예외처리 => 반드시 예외처리 한다 
			// java.io,java.net,java.sql  => 체크예외처리
		}catch(Exception ex) {}
	}
	// 2. 오라클 연결 
	public void getConnection()
	{
		try
		{
			conn=DriverManager.getConnection(URL,"hr","happy");
			// conn hr/happy => 명령어를 오라클 전송 
		}catch(Exception ex) {}
	}
	// 3. 오리클 해제
	public void disConnection()
	{
		try
		{
			if(ps!=null) ps.close(); // 통신이 열려있으면 닫는다
			if(conn!=null) conn.close();
			// exit => 오라클 닫기 
		}catch(Exception ex) {}
	}
	public static FoodDAO newInstance()
	{
		if(dao==null)
			dao=new FoodDAO();
		return dao;
	}
	public List<FoodVO> foodAllData(){
		List<FoodVO> list=new ArrayList<FoodVO>();
		try {
			getConnection();
			String sql="SELECT name,address,poster,phone,type "
					+ "FROM food_house "
					+ "ORDER BY fno ASC";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				FoodVO vo=new FoodVO();
				String name=rs.getString(1);
				vo.setName(name);
				String addr=rs.getString(2);
				addr=addr.substring(0,addr.lastIndexOf("지번"));
				vo.setAddress(addr.trim());
				String poster=rs.getString(3);
				poster=poster.substring(0,poster.indexOf("^"));
				// 원자값
				poster=poster.replace("#", "&");
				vo.setPoster(poster);
				vo.setPhone(rs.getString(4));
				vo.setType(rs.getString(5));
				list.add(vo);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			disConnection();
		}
		return list;
	}
}
