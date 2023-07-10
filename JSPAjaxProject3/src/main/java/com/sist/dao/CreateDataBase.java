package com.sist.dao;
import java.util.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
public class CreateDataBase {
	public Connection getConnection() {
		Connection conn=null;
		try {
			Context init = new InitialContext();
			Context c=(Context)init.lookup("java://comp/env");
			DataSource ds=(DataSource)c.lookup("jdbc/oracle");
			conn=ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return conn;
	}
	public void disConnection(Connection conn,PreparedStatement ps) {
		try {
			if(conn!=null) conn.close();
			if(ps!=null) ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void disConnection(Connection conn,CallableStatement ps) {
							//				  ----------------- 프로시져 호출할때 사용
		try {
			if(conn!=null) conn.close();
			if(ps!=null) ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}