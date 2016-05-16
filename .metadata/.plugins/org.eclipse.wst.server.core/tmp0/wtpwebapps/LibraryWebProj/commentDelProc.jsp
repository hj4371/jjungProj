<%@page import="com.Library.vo.Comment"%>
<%@page import="com.Library.dao.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%    
	String seq = request.getParameter("seq");
	String regnum = request.getParameter("regnum");
	
	CommentDAO dao = new CommentDAO();
	Comment c = new Comment();
	c.setSeq(seq);

	
	
	
	int af = dao.deleteComment(c);
	if (af == 1)
	{
		response.sendRedirect("bookDetail.jsp?regnum="+regnum);
	}
	else
	{
		System.out.println("댓글삭제실패");
	}
	
%>