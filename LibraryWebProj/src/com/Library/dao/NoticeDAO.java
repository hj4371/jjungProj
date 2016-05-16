package com.Library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.Library.vo.Notice;

public class NoticeDAO {

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

	public Notice getNotice(String seq) {
		Connection con = null;
		//Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Notice n = null;

		String sql = "SELECT * FROM LNOTICES WHERE SEQ=?";
		String sql2 = "UPDATE LNOTICES SET HIT=((SELECT HIT FROM LNOTICES WHERE SEQ=?)+1) WHERE SEQ=?";

		con = getConn();
		try {		
			ps = con.prepareStatement(sql2);
			ps.setString(1, seq);
			ps.setString(2, seq);			
			ps.executeUpdate();
			
			ps = con.prepareStatement(sql);
			ps.setString(1, seq);		
			rs = ps.executeQuery();
			
			if(rs.next())
			{
				n = new Notice();
				n.setSeq(rs.getString("seq"));
				n.setTitle(rs.getString("title"));
				n.setWriter(rs.getString("writer"));
				n.setContent(rs.getString("content"));
				n.setRegdate(rs.getString("regdate"));
				n.setHit(rs.getInt("hit"));
			}
		} catch (SQLException e) {
			System.out.println("게시판 조회중에 오류발생");
			e.printStackTrace();
		} finally {	
			try {
				rs.close();
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("접속해제 실패하였습니다.");
				e.printStackTrace();
			}
		}
		return n;
	}
	
	//paging
	public List<Notice> getNotices(int pages, int pagenum)
	{

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Notice n = null;
		
		int startNum = 1 + (pages-1)*pagenum;
				
		int endNum = pagenum + (pages-1)*pagenum;

		String sql = "SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM LNOTICES ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN ? AND ?";

		List<Notice> list = new ArrayList<Notice>();
		con = getConn();
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, startNum);
			ps.setInt(2, endNum);
			rs = ps.executeQuery();

			while(rs.next())
			{
				n = new Notice();				
				n.setSeq(rs.getString("seq"));
				n.setTitle(rs.getString("title"));
				n.setWriter(rs.getString("writer"));
				n.setContent(rs.getString("content"));
				n.setRegdate(rs.getString("regdate"));
				n.setHit(rs.getInt("hit"));

				list.add(n);
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
	
	public List<Notice> searchNotices(String search, String filter, int pages) 
	{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Notice n = null;
		
		int startNum = 1 + (pages-1)*10;
		int endNum = 10 + (pages-1)*10;
		
		String sql="";

		if(search==null||filter==null||search.equals("null")||filter.equals("null")) {
			sql = "SELECT * FROM (SELECT ROWNUM NUM, L.* FROM (SELECT * FROM LNOTICES ORDER BY SEQ DESC) L) WHERE NUM BETWEEN ? AND ?";
		} else {
			sql = "SELECT * FROM (SELECT ROWNUM NUM, L.* FROM (SELECT * FROM LNOTICES WHERE "+  filter +" LIKE '%"+search+"%' ORDER BY SEQ DESC) L) WHERE NUM BETWEEN ? AND ?";
		}
		
		List<Notice> list = new ArrayList<Notice>();
		con = getConn();
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, startNum);
			ps.setInt(2, endNum);
			rs = ps.executeQuery();
			
			while(rs.next())
			{
				n = new Notice();				
				n.setSeq(rs.getString("seq"));
				n .setTitle(rs.getString("title"));
				n. setWriter(rs.getString("writer"));
				n.setContent(rs.getString("content"));
				n.setRegdate(rs.getString("regdate"));
				n.setHit(rs.getInt("hit"));      
				
				list.add(n);
			}
		} catch (SQLException e) {
			System.out.println("call list error.");
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("connect error.");
				e.printStackTrace();
			}
		}
		return list;
	}	
	
	public int insertNotice(Notice n)
	{
		Connection con = null;
		PreparedStatement ps = null;
		int af = 0;

		String sql = "INSERT INTO LNOTICES (SEQ, TITLE, WRITER, CONTENT, REGDATE, HIT) "
				+ "VALUES((SELECT NVL(MAX(TO_NUMBER(SEQ))+1,1) FROM LNOTICES), ?, ?, ?, SYSDATE, 0)";
		con = getConn();

		try 
		{
			ps = con.prepareStatement(sql);
			ps.setString(1, n.getTitle());
			ps.setString(2, n.getWriter());
			ps.setString(3, n.getContent()); 

			af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("글쓰기 성공하였습니다.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {	
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("글쓰기에 실패했습니다.");
				e.printStackTrace();
			}
		}
		return af;
	}
	
	public int updateNotice(Notice n)
	{
		Connection con = null;
		PreparedStatement ps = null;
		int af = 0;

		String sql = "UPDATE LNOTICES SET TITLE=?, CONTENT=? WHERE SEQ=?";
		con = getConn();

		try 
		{
			ps = con.prepareStatement(sql); 
			ps.setString(1, n.getTitle()); 
			ps.setString(2, n.getContent());
			ps.setString(3, n.getSeq());

			af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("글 수정에 성공했습니다.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {	
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("글 수정에 실패했습니다.");
				e.printStackTrace();
			}
		}
		return af;
	}
	
	public int deleteNotice(Notice n) 
	{
		Connection con = null;
		PreparedStatement ps = null;
		int af = 0;
		
		String sql = "DELETE LNOTICES WHERE SEQ=?";
		con = getConn();

		try 
		{
			ps = con.prepareStatement(sql); 
			ps.setString(1, n.getSeq());
			
			af = ps.executeUpdate(); 	
			if (af == 1) 
			{
				System.out.println("글 삭제에 성공했습니다.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {	
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("글 삭제 실패했습니다.");
				e.printStackTrace();
			}
		}
		return af;
	}
	
	
	public int getCount() 
	{
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		int count = 0;

		String sql = "SELECT COUNT(SEQ) CNT FROM LNOTICES";

		con = getConn();
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			
			if (rs.next())
			{
				count = rs.getInt("CNT");
			}
		} catch (SQLException e) {
			System.out.println("글 목록 로드 중에 오류 발생");
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				st.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("목록 로드 실패.");
				e.printStackTrace();
			}
		}
		return count;
	}
}
