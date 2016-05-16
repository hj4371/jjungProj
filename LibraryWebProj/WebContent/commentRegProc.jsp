<%@page import="com.Library.dao.CommentDAO"%>
<%@page import="com.Library.vo.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String _regnum = request.getParameter("regnum");
	int regnum = 0;
	if (_regnum != null && !_regnum.equals("")) {
		regnum = Integer.parseInt(_regnum);
	}
	String mid = (String) request.getSession().getAttribute("mid");
	String content = request.getParameter("content");

	Comment c = new Comment();

	c.setRegnum(regnum);
	c.setContent(content);
	c.setWriter(mid);

	CommentDAO dao = new CommentDAO();

	int af = dao.insertComment(c);
	if (af == 1) {
		response.sendRedirect("bookDetail.jsp?regnum="+regnum);
	}
%>