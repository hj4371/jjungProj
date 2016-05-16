<%@page import="com.Library.vo.Member"%>
<%@page import="com.Library.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mid = request.getParameter("mid");
	String pwd = request.getParameter("pwd");
	
	MemberDAO dao = new MemberDAO();
	Member m = dao.getMember(mid);
	
	if(m==null) {
		//no id
		request.setAttribute("error", "id doesnt exist");
		request.getRequestDispatcher("main.jsp").forward(request, response);
		System.out.println("no id");
		
	} else if(!m.getPwd().equals(pwd)) {
		//pwd doesnt match
		request.setAttribute("error", "wrong pwd");
		request.getRequestDispatcher("main.jsp").forward(request, response);
		
	} else {
		//fine login
		request.getSession().setAttribute("mid", mid); 
		
		String returnURL = (String)request.getSession().getAttribute("returnURL");
		if(returnURL !=null && !returnURL.equals("")) {
			//came frm other pages
			String ctName = request.getContextPath();
			response.sendRedirect(ctName + returnURL);
		} else {
			//just login
			response.sendRedirect("main.jsp?mid="+mid);
		}
	}
	
%>
