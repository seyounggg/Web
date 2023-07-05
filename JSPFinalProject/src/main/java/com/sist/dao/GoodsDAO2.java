package com.sist.dao;
import java.util.*;
import java.sql.*;
public class GoodsDAO2 {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	public GoodsDAO2() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {}
	}
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch (Exception e) {}
	}
	public void disConnection() {
		try {
			if(conn!=null) conn.close();
			if(ps!=null) ps.close();
		} catch (Exception e) {}
	}
	public List<Integer> goodsGetNo(String tab){
		List<Integer> list=new ArrayList<Integer>();
		try {
			getConnection();
			String sql="SELECT no FROM "+tab+" ORDER BY no ASC";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				int no=rs.getInt(1);
				list.add(no);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
	
	public void goodsAccountInsert(int account,int no,String tab) {
		try {
			getConnection();
			String sql="UPDATE "+tab+" SET account=? "
					+ "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, account);
			ps.setInt(2, no);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}
	public static void main(String[] args) {
		GoodsDAO2 dao=new GoodsDAO2();
		List<Integer> list=dao.goodsGetNo("goods_special");
		for(int no:list) {
			int account=(int)(Math.random()*50)+11;
			dao.goodsAccountInsert(account, no, "goods_special");
		}
		// ps.executeUpdate() 에는 commit이 포함되어 있엄 (autoCommit)
		// 느린 이유가 하나 추가하고 커밋하고 이래서 느린거임
		System.out.println("완료");
	}
}
