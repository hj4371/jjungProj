<%@page import="com.Library.dao.MemberDAO"%>
<%@page import="com.Library.vo.Member"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mid = request.getParameter("mid");
	String pwd = request.getParameter("pwd");
	String pwd2 = request.getParameter("pwd2");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birthday = String.format("%s-%s-%s", year, month, day);
	
	String phone = request.getParameter("phone");
	
//-----------------------------------------------------------------------------------------중복체크
	MemberDAO dao = new MemberDAO();
	Member mm = new Member();
	mm.setMid(mid);
	mm.setPwd(pwd);
	mm.setName(name);
	mm.setGender(gender);
	mm.setBirthday(birthday);
	mm.setPhone(phone);
	
	int af = dao.addMember(mm);
	request.getSession().setAttribute("mid", mid);
	if(af==1) {
		response.sendRedirect("main.jsp?mid=" + mid);	
	} else {
		out.write("회원 가입 중 오류 발생");
	}
	
%>
