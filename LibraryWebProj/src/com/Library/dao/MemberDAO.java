package com.Library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.Library.vo.Member;


public class MemberDAO { // Database Access Object

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
			System.out.println("연결실.");
			e.printStackTrace();
		}

		return con;
	}
	
	public Member getMember(String mid) {
		Connection con = null;
		//Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Member m = null;

		String sql = "SELECT * FROM LMEMBERS WHERE MID=?";

		con = getConn();
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, mid);
			rs = ps.executeQuery();
			if(rs.next())
			{
				m = new Member();
				m.setMid(rs.getString("mid"));
				m.setPwd(rs.getString("pwd"));
				m.setName(rs.getString("name"));
				m.setGender(rs.getString("gender"));
				m.setBirthday(rs.getString("birthday"));
				m.setPhone(rs.getString("phone"));
				m.setRegdate(rs.getString("regdate"));
				m.setBookregnum(rs.getInt("bookregnum"));
				m.setReturndate(rs.getString("returndate"));
			}

		} catch (SQLException e) {
			System.out.println("회원조회 중 오류발생.");
			e.printStackTrace();
		} finally {	
			try {
				rs.close();
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("접속해제 실패.");
				e.printStackTrace();
			}
		}
		return m;
	}

	
	public int addMember(Member m) 
	{
		Connection con = null;
		PreparedStatement ps = null;
		int af = 0;
		String sql = "INSERT INTO LMEMBERS "
				+ "(MID, PWD, NAME, GENDER, BIRTHDAY, PHONE, REGDATE, BOOKREGNUM)"
				+ "VALUES(?, ?, ?, ?, ?, ?, SYSDATE, 0)";
		con = getConn();

		try 
		{
			ps = con.prepareStatement(sql); 
			ps.setString(1, m.getMid()); 
			ps.setString(2, m.getPwd()); 
			ps.setString(3, m.getName());
			ps.setString(4, m.getGender());
			ps.setString(5, m.getBirthday());
			ps.setString(6, m.getPhone());

			af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("회원 추가 성공.");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {	
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("회원가입 중 오류발생.");
				e.printStackTrace();
			}
		}
		return af;
	}
	
	
	public int UpdateMember(Member m) 
	{
		Connection con = null;
		PreparedStatement ps = null;

		String sql = "UPDATE LMEMBERS SET GENDER=?, BIRTHDAY=?, PHONE=? WHERE MID=?";
		con = getConn();
		int af=0;
		try 
		{
			ps = con.prepareStatement(sql); 
			ps.setString(1, m.getGender());
			ps.setString(2, m.getBirthday());
			ps.setString(3, m.getPhone());
			ps.setString(4, m.getMid());
			
			af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("업데이트 성공.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("업데이트 도중 오류발생.");
				e.printStackTrace();
			}
		}		
		return af;
	}

	public int delMember(String mid) 
	{
		Connection con = null;
		PreparedStatement ps = null;

		String sql = "DELETE LMEMBERS WHERE MID=?";
		con = getConn();
		int af=0;
		try 
		{
			ps = con.prepareStatement(sql); 
			ps.setString(1, mid);
			
			af = ps.executeUpdate(); 
			if (af == 1) 
			{
				System.out.println("회원삭제 성공.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {	
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("회원삭제 중 오류발생.");
				e.printStackTrace();
			}
		}	
		return af;
	}
	
	
	public List<Member> getMembers(String col) 
	{
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		Member m = null;

		String sql = "SELECT * FROM LMEMBERS ORDER BY " + col;
		
		List<Member> list = new ArrayList<Member>();
		con = getConn();
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next())
			{
				m = new Member();				
				m.setMid(rs.getString("mid"));
				m.setPwd(rs.getString("pwd"));
				m.setName(rs.getString("name"));
				m.setGender(rs.getString("gender"));
				m.setBirthday(rs.getString("birthday"));
				m.setPhone(rs.getString("phone"));
				m.setRegdate(rs.getString("regdate"));
				m.setBookregnum(rs.getInt("bookregnum"));
				m.setReturndate(rs.getString("returndate"));
				
				list.add(m);
			}
		} catch (SQLException e) {
			System.out.println("회원리스트 부르기 성공.");
			e.printStackTrace();
		} finally {	
			try {
				rs.close();
				st.close();
				con.close();
			} catch (SQLException e) {
				System.out.println("회원리스트 생성 실패.");
				e.printStackTrace();
			}
		}
		return list;

	}


	
	
}
