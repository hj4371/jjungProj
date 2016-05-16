<%@page import="com.Library.vo.Member"%>
<%@page import="com.Library.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String mid = request.getParameter("mid");

	MemberDAO dao = new MemberDAO();
	Member m = dao.getMember(mid);
	
	if(m == null){
 		out.write("YES");
 		//System.out.println(mid);
 	}else{
 		out.write("NO");
 		//System.out.println(mid);
 	}

%>
