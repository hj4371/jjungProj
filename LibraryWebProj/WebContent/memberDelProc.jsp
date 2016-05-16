<%@page import="com.Library.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String mid = (String)request.getSession().getAttribute("mid");

	MemberDAO dao = new MemberDAO();
	//Member m = new Member();
	//m.setMid(mid);
	
	int af = dao.delMember(mid);
	if (af==1)
	{
		request.getSession().invalidate();
		response.sendRedirect("main.jsp");
	}
	else 
	{
		out.write("회원 삭제 중 오류 발생");
	}
%>