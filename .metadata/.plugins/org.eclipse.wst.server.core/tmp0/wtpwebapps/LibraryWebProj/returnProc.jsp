<%@page import="com.Library.dao.BooklistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String _regnum = request.getParameter("regnum");
	int regnum = 0;
	if (_regnum != null && !_regnum.equals("")) {
		regnum = Integer.parseInt(_regnum);
	}

	String mid = (String) request.getSession().getAttribute("mid");
	
	BooklistDAO dao = new BooklistDAO();
	int af = dao.returnBook(regnum, mid);
	if (af > 0) {
		request.getRequestDispatcher("bookDetail.jsp?regnum=" + regnum).forward(request, response);
	} else {
		System.out.println("error");
	}
	
%>