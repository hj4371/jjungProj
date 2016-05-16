package com.Library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Library.vo.Request;

public class RequestDAO {
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@211.238.142.130:1521:orcl";
	private String user = "scott";
	private String pwd = "111111";

	public Connection getConn() {
		Connection con = null; 

		try {
			Class.forName(driver); 
		} catch (ClassNotFoundException e) { 
			System.out.println("드라이버 로드에 실패하였습니다.");
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection(url, user, pwd);
		} catch (SQLException e) {
			System.out.println("연결에 실패하였습니다.");
			e.printStackTrace();
		}

		return con;
	}
	
	public int addRequest(Request r) 
	{
		Connection con = null;
		PreparedStatement ps = null;
		int af = 0;
		String sql = "INSERT INTO LREQUESTS (SEQ, TITLE, WRITER, REGDATE, PUBLISH) "
				+ "VALUES((SELECT NVL(MAX(TO_NUMBER(SEQ))+1,1) FROM LREQUESTS), ?, ?, SYSDATE, ?)";
		con = getConn();

		try 
		{
			ps = con.prepareStatement(sql); 
			ps.setString(1, r.getTitle()); 
			ps.setString(2, r.getWriter()); 
			ps.setString(3, r.getPublish());

			af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("request 추가 성공.");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {	
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("request 처리 중 오류발생.");
				e.printStackTrace();
			}
		}
		return af;
	}

	//paging
	public List<Request> getRequests(int pages, int pagenum) {

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Request r = null;

		int startNum = 1 + (pages-1)*pagenum;

		int endNum = pagenum + (pages-1)*pagenum;

		String sql = "SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM LREQUESTS ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN ? AND ?";

		List<Request> list = new ArrayList<Request>();
		con = getConn();
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, startNum);
			ps.setInt(2, endNum);
			rs = ps.executeQuery();

			while(rs.next())
			{
				r = new Request();				
				r.setSeq(rs.getString("seq"));
				r.setTitle(rs.getString("title"));
				r.setWriter(rs.getString("writer"));
				r.setRegdate(rs.getString("regdate"));
				r.setPublish(rs.getString("publish"));

				list.add(r);
			}
		} catch (SQLException e) {
			System.out.println("조회 중에 오류발생");
			e.printStackTrace();
		} finally {	
			try {
				rs.close();
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("게시판 접속에 실패.");
				e.printStackTrace();
			}
		}
		return list;
	}

}
