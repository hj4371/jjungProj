<%@page import="com.Library.dao.NoticeDAO"%>
<%@page import="com.Library.vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String seq = request.getParameter("seq");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String pages = request.getParameter("pages");
	//System.out.println("seq"+seq+"pages"+pages);
	Notice n = new Notice();
	
	n.setSeq(seq);
	n.setTitle(title);
	n.setContent(content);
	
	NoticeDAO dao = new NoticeDAO();
	
	int af = dao.updateNotice(n);
	if (af == 1)
	{
		response.sendRedirect("noticeDetail.jsp?seq=" + seq + "&pages=" + pages);
	} else {
		System.out.println("수정 실패.");
	}
%>