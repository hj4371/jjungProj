<%@page import="com.Library.vo.Request"%>
<%@page import="com.Library.dao.RequestDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String bookname = request.getParameter("bookname");
	String writer = request.getParameter("writer");
	String publish = request.getParameter("publish");

	
//-----------------------------------------------------------------------------------------중복체크
	RequestDAO dao = new RequestDAO();
	Request rr = new Request();
	rr.setTitle(bookname);
	rr.setWriter(writer);
	rr.setPublish(publish);

	int af = dao.addRequest(rr);
	if(af==1) {
		response.sendRedirect("ask.jsp");	
	} else {
		out.write("request 추가 중 오류 발생");
	}
	
%>
