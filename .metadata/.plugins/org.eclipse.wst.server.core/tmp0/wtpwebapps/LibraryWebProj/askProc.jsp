<%@page import="com.Library.vo.Booklist"%>
<%@page import="com.Library.dao.BooklistDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String bookname = request.getParameter("bookname");
	String writer = request.getParameter("writer");
	String publish = request.getParameter("publish");

	
//-----------------------------------------------------------------------------------------중복체크
	BooklistDAO dao = new BooklistDAO();
	Booklist dd = new Booklist();
	dd.setBookname(bookname);
	dd.setWriter(writer);
	dd.setPublish(publish);

	int af = dao.addMember(mm);
	request.getSession().setAttribute("mid", mid);
	if(af==1) {
		response.sendRedirect("main.jsp?mid=" + mid);	
	} else {
		out.write("회원 가입 중 오류 발생");
	}
	
%>
