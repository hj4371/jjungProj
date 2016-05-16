<%@page import="com.Library.vo.Booklist"%>
<%@page import="com.Library.dao.BooklistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String bookname = request.getParameter("bookname");

	BooklistDAO dao = new BooklistDAO();
	int num = dao.getCount(bookname, "bookname");
	
	if(num==0){
 		out.write("YES");
 		//System.out.println(mid);
 	}else{
 		out.write("NO");
 		//System.out.println(mid);
 	}

%>
