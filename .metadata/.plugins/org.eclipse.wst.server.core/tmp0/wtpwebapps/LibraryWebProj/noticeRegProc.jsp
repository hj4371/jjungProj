<%@page import="com.Library.dao.NoticeDAO"%>
<%@page import="com.Library.vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String title = request.getParameter("title");
	String mid = (String) request.getSession().getAttribute("mid");
	String content = request.getParameter("content");
	
	Notice n = new Notice();
	
	n.setTitle(title);
	n.setContent(content);
	n.setWriter(mid);
	
	NoticeDAO dao = new NoticeDAO();
	
	int af = dao.insertNotice(n);
	if (af == 1)
	{
		response.sendRedirect("notice.jsp");
	} 
	
%>