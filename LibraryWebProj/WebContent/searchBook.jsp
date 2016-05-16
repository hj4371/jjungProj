<%@page import="com.Library.vo.Member"%>
<%@page import="com.Library.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>

<%
	request.setCharacterEncoding("utf-8");
	String mid = null;
	if(request.getSession().getAttribute("mid")!=null)  {
		mid = (String)request.getSession().getAttribute("mid");
		
		String search = request.getParameter("search");
		String filter = request.getParameter("filter");
				
		response.sendRedirect("books.jsp?search=" + URLEncoder.encode(search, "UTF-8")+"&filter="+filter);	
		
	} else {
		response.sendRedirect("login.jsp");	
	}	
	
%>
