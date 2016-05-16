<%@page import="com.Library.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String mid = request.getParameter("mid");

	MemberDAO dao = new MemberDAO();
	//Member m = new Member();
	//m.setMid(mid);
	
	int af = dao.delMember(mid);
	if (af==1)
	{
		response.sendRedirect("AdminPage.jsp");
	}
	else 
	{
		out.write("회원 삭제 중 오류 발생");
	}
%>