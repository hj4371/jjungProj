<%@page import="com.Library.dao.NoticeDAO"%>
<%@page import="com.Library.vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%    
	String seq = request.getParameter("seq");
	
	Notice n = new Notice();
	
	n.setSeq(seq);

	
	NoticeDAO dao = new NoticeDAO();
	
	int af = dao.deleteNotice(n);
	if (af == 1)
	{
		response.sendRedirect("notice.jsp");
	}
	else
	{
		
	}
	
%>