<%@page import="com.Library.vo.Member"%>
<%@page import="com.Library.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String mid = (String) request.getSession().getAttribute("mid");
	String pwd = request.getParameter("pwd");
	String pwd2 = request.getParameter("pwd2");
	
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birthday = String.format("%s-%s-%s", year, month, day);
	String phone = request.getParameter("phone");
	
	MemberDAO dao = new MemberDAO();
	Member m = dao.getMember(mid);
	
	m.setPwd(pwd);
	m.setBirthday(birthday);
	m.setPhone(phone);
	
	int af = dao.UpdateMember(m);
	if (af == 1)
	{
		response.sendRedirect("mypage.jsp");
	}
%>