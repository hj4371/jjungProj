package com.Library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.Library.vo.Booklist;

public class BooklistDAO {
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@211.238.142.130:1521:orcl";
	private String user = "scott";
	private String pwd = "111111";
	
	public Connection getConn() {
		Connection con = null; 

		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			System.out.println("driver load fail.");
			e.printStackTrace();
		}

		try {
			
			con = DriverManager.getConnection(url, user, pwd);
		} catch (SQLException e) {
			System.out.println("connect fail.");
			e.printStackTrace();
		}

		return con;
	}
	
	public Booklist getBooklist(int regnum) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Booklist b = null;
		String sql = "SELECT * FROM BOOKLIST WHERE REGNUM=?";
		
		con = getConn();
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, regnum);
			rs = ps.executeQuery();
			if(rs.next())
			{
				b = new Booklist();
				b.setRegnum(rs.getInt("regnum"));
				b .setBookname(rs.getString("bookname"));
				b. setISBN(rs.getString("ISBN"));
				b.setCategory(rs.getString("category"));
				b.setWriter(rs.getString("writer"));
				b.setPublish(rs.getString("publish"));
				b.setLocations(rs.getString("locations"));
				b.setStatus(rs.getString("status"));
				b.setHit(rs.getInt("hit"));     
				b.setBooking(rs.getInt("booking"));  
				b.setReturndate(rs.getString("returndate"));
				b.setImg(rs.getString("img"));
			}

		} catch (SQLException e) {
			System.out.println("list call error.");
			e.printStackTrace();
		} finally {	
			try {
				rs.close();
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("connection end error.");
				e.printStackTrace();
			}
		}
		return b;
	}

	public int insertBooklist(Booklist b) 
	{
		Connection con = null;
		PreparedStatement ps = null;
		int af = 0;
		String sql = "INSERT INTO BOOKLIST (REGNUM, BOOKNAME, ISBN, CATEGORY, WRITER, PUBLISH, LOCATIONS, STATUS, HIT, BOOKING, RETURNDATE, IMG)"
				+ "VALUES((SELECT MAX(REGNUM)+1 FROM BOOKLIST), ?, ?, ?, ?, ?, ?, ?, 0, 0, ?, ?)";
		con = getConn();

		try 
		{
			ps = con.prepareStatement(sql); 
			ps.setString(1,b.getBookname()); 
			ps.setString(2,b.getISBN());
			ps.setString(3, b.getCategory());
			ps.setString(4, b.getWriter());
			ps.setString(5, b.getPublish());
			ps.setString(6, b.getLocations());
			ps.setString(7, b.getStatus());
			ps.setInt(8, b.getHit());
			ps.setInt(9, b.getBooking());
			ps.setString(10, b.getReturndate());
			ps.setString(11, b.getImg());
			
			af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("insert success.");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("insert fail.");
				e.printStackTrace();
			}
		}
		return af;
	}
	
	public int lendBook(int regnum, String mid) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int af = 0;
		MemberDAO dao = new MemberDAO();
		
		
		String sql = "UPDATE BOOKLIST SET HIT=((SELECT HIT FROM BOOKLIST WHERE REGNUM=?)+1), STATUS = ?, RETURNDATE = SYSDATE+7 WHERE REGNUM=?";
		String sql2 = "UPDATE LMEMBERS SET BOOKREGNUM = ?, RETURNDATE = SYSDATE+7 WHERE MID =?";
		
		con = getConn();

		try 
		{
			ps = con.prepareStatement(sql2);
			ps.setInt(1, regnum);
			ps.setString(2, mid);			
			ps.executeUpdate();
			
			ps = con.prepareStatement(sql);
			ps.setInt(1, regnum);
			ps.setString(2, mid);
			ps.setInt(3, regnum);		
			rs = ps.executeQuery();
			
			af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("->update success.");
			} else {
				System.out.println("update error.");
			}
		} catch (SQLException e) {
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
		return af;
	}
	
	public int returnBook(int regnum, String mid) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int af = 0;
	
		
		String sql = "UPDATE BOOKLIST SET STATUS = '대출가능', RETURNDATE = '' WHERE REGNUM=?";
		String sql2 = "UPDATE LMEMBERS SET BOOKREGNUM = 0, RETURNDATE = '' WHERE MID =?";
		
		con = getConn();

		try 
		{
			ps = con.prepareStatement(sql2);
			ps.setString(1, mid);			
			ps.executeUpdate();
			
			ps = con.prepareStatement(sql);
			ps.setInt(1, regnum);		
			rs = ps.executeQuery();
			
			af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("->update success.");
			} else {
				System.out.println("update error.");
			}
		} catch (SQLException e) {
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
		return af;
	}
	
	public void delBookList(Booklist b) 
	{
		Connection con = null;
		PreparedStatement ps = null;

		String sql = "DELETE BOOKLIST WHERE REGNUM=?";
		con = getConn();

		try 
		{
			ps = con.prepareStatement(sql); 
			ps.setInt(1, b.getRegnum());
			
			int af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("delete success.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {	
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("delete fail.");
				e.printStackTrace();
			}
		}		
	}
	
	public List<Booklist> getBooklists(int pages, int pagenum) 
	{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Booklist b = null;
		
		int startNum = 1 + (pages-1)*pagenum;
		int endNum = pagenum + (pages-1)*pagenum;

		String sql = "SELECT * FROM (SELECT ROWNUM NUM, L.* FROM (SELECT * FROM BOOKLIST ORDER BY REGNUM DESC) L) WHERE NUM BETWEEN ? AND ?";
		
		List<Booklist> list = new ArrayList<Booklist>();
		con = getConn();
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, startNum);
			ps.setInt(2, endNum);
			rs = ps.executeQuery();
			
			while(rs.next())
			{
				b = new Booklist();				
				b.setRegnum(rs.getInt("regnum"));
				b .setBookname(rs.getString("bookname"));
				b. setISBN(rs.getString("ISBN"));
				b.setWriter(rs.getString("writer"));
				b.setPublish(rs.getString("publish"));
				b.setHit(rs.getInt("hit"));      
				
				list.add(b);
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
	
	public List<Booklist> searchBooks(String search, String filter, int pages) 
	{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Booklist b = null;
		
		int startNum = 1 + (pages-1)*10;
		int endNum = 10 + (pages-1)*10;
		
		String sql="";

		if(search==null||filter==null||search.equals("null")||filter.equals("null")) {
			sql = "SELECT * FROM (SELECT ROWNUM NUM, L.* FROM (SELECT * FROM BOOKLIST ORDER BY REGNUM DESC) L) WHERE NUM BETWEEN ? AND ?";
		} else {
			sql = "SELECT * FROM (SELECT ROWNUM NUM, L.* FROM (SELECT * FROM BOOKLIST WHERE "+  filter +" LIKE '%"+search+"%' ORDER BY REGNUM DESC) L) WHERE NUM BETWEEN ? AND ?";
		}
		
		List<Booklist> list = new ArrayList<Booklist>();
		con = getConn();
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, startNum);
			ps.setInt(2, endNum);
			rs = ps.executeQuery();
			
			while(rs.next())
			{
				b = new Booklist();				
				b.setRegnum(rs.getInt("regnum"));
				b .setBookname(rs.getString("bookname"));
				b. setISBN(rs.getString("ISBN"));
				b.setWriter(rs.getString("writer"));
				b.setPublish(rs.getString("publish"));
				b.setHit(rs.getInt("hit"));      
				
				list.add(b);
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
	
	public List<Booklist> getBestSeller() {
		Connection con = null;
		Statement st  = null;
		ResultSet rs = null;
		Booklist b = null;
		
		String sql = "SELECT * FROM (SELECT ROWNUM NUM, L.* FROM(SELECT * FROM BOOKLIST ORDER BY HIT DESC) L) WHERE NUM BETWEEN 1 AND 5";
		
		List<Booklist> list = new ArrayList<Booklist>();
		con = getConn();
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next())
			{
				b = new Booklist();				
				b.setRegnum(rs.getInt("regnum"));
				b .setBookname(rs.getString("bookname"));
				b. setISBN(rs.getString("ISBN"));
				b.setWriter(rs.getString("writer"));
				b.setPublish(rs.getString("publish"));
				b.setHit(rs.getInt("hit"));  
				b.setImg(rs.getString("img"));
				
				list.add(b);
			}
		} catch (SQLException e) {
			System.out.println("call list error.");
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				st.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("connect error.");
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public List<Booklist> getNewOnes() {
		Connection con = null;
		Statement st  = null;
		ResultSet rs = null;
		Booklist b = null;
		
		String sql = "SELECT * FROM (SELECT ROWNUM NUM, L.* FROM(SELECT * FROM BOOKLIST ORDER BY REGNUM DESC) L) WHERE NUM BETWEEN 1 AND 5";
		
		List<Booklist> list = new ArrayList<Booklist>();
		con = getConn();
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next())
			{
				b = new Booklist();				
				b.setRegnum(rs.getInt("regnum"));
				b .setBookname(rs.getString("bookname"));
				b. setISBN(rs.getString("ISBN"));
				b.setWriter(rs.getString("writer"));
				b.setPublish(rs.getString("publish"));
				b.setHit(rs.getInt("hit"));  
				b.setImg(rs.getString("img"));
				
				list.add(b);
			}
		} catch (SQLException e) {
			System.out.println("call list error.");
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				st.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("connect error.");
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int getCount() {
		Connection con = null;
		Statement st  = null;
		ResultSet rs = null;
		int count = 0;
		
		String sql = "SELECT COUNT(REGNUM) CNT FROM BOOKLIST";
		
		con = getConn();
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			
			if(rs.next())	{
				count = rs.getInt("CNT");
			}
		} catch (SQLException e) {
			System.out.println("counting error");
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				st.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("connect error.");
				e.printStackTrace();
			}
		}
		return count;
	}

	public int getCount(String search, String filter) {
		Connection con = null;
		Statement st  = null;
		ResultSet rs = null;
		int count = 0;

		String sql="";
		
		if(search==null||filter==null||search.equals("null")||filter.equals("null")) {
			sql = "SELECT COUNT(REGNUM) CNT FROM BOOKLIST";
		} else {
			sql = "SELECT COUNT(REGNUM) CNT FROM (SELECT L.* FROM(SELECT * FROM BOOKLIST ORDER BY REGNUM DESC) L) WHERE "+filter+" Like '%"+search+"%'";
		}
		
		con = getConn();
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			
			if(rs.next())	{
				count = rs.getInt("CNT");
			}
		} catch (SQLException e) {
			System.out.println("counting error");
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				st.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("connect error.");
				e.printStackTrace();
			}
		}
		return count;
	}

}
