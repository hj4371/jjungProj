<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.Library.dao.BooklistDAO"%>
<%@page import="com.Library.vo.Member"%>
<%@page import="com.Library.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mid = (String) request.getSession().getAttribute("mid");

	MemberDAO dao = new MemberDAO();
	Member m = dao.getMember(mid);
	
	BooklistDAO bdao = new BooklistDAO();
	int regnum = m.getBookregnum();
	String bookname = "";
	int i = 0;
	
	if(bdao.getBooklist(regnum)!=null) {
		bookname = bdao.getBooklist(m.getBookregnum()).getBookname();
		
		String _returndate = bdao.getBooklist(m.getBookregnum()).getReturndate();
		Date returndate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(_returndate);
		Date now = new Date();
		i=returndate.compareTo(now);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/mypage.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body>
	<% if (mid == null) { %>
	<jsp:include page="header.jsp" flush="flase"></jsp:include>
	<% } else { %>
	<jsp:include page="welcomeheader.jsp" flush="flase"></jsp:include>
	<% } %>
	
	<section>
	<div id="main">
			<div class="top-wrapper clear">
				<div id="content">
					<form action="memberUpdateProc.jsp" method="post">
						<h2><%=mid %>'s Page</h2>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*아이디
								</dt>
								<dd class="join-form-data">
									<%=mid %>
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*비밀번호
								</dt>
								<dd class="join-form-data">
									<input type="password" name="pwd" value="<%=m.getPwd() %>" required />
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*비밀번호 확인
								</dt>
								<dd class="join-form-data" >
									<input type="password" name="pwd2" value="<%=m.getPwd() %>" required />
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*이름
								</dt>
								<dd class="join-form-data">
									<%=m.getName() %>
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*성별
								</dt>
								<dd class="join-form-data">
									<%=m.getGender() %>
								</dd>
							</dl>
							<dl class="join-form-row birthday">
								<dt class="join-form-title">
									*생년월일
								</dt>
								<dd class="join-form-data">								
	                                <span>
	                                    <input type="text" name="year" value="<%=m.getBirthday().substring(0, 4) %>" id="year"  pattern="[12][09][0-9]{2}"/>년
	                                    	<%-- <%if ( m.getBirthday().substring(6, 7).length() = 1){%>
	                                    		<input type="text" name="month" value="<%=0+m.getBirthday().substring(6, 7) %>"  id="month" pattern="[01][0-9]"/>월
	                                    	<%} else {%>
	                                    		<input type="text" name="month" value="<%=m.getBirthday().substring(6, 7) %>"  id="month" pattern="[01][0-9]"/>월
	                                    	<%} %> --%>
	                                    <input type="text" name="month" value="<%=m.getBirthday().substring(5, 7) %>"  id="month" pattern="[01][0-9]"/>월
	                                    <input type="text" name="day" value="<%=m.getBirthday().substring(8) %>" id="day"  pattern="[0-3][0-9]"/>일
	                                </span>
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*핸드폰 번호
								</dt>
								<dd class="join-form-data">
									<input type="text" name="phone" required value="<%=m.getPhone() %>" pattern="01[016789]-[0-9]{3,4}-[0-9]{4}"/><span> 대시(-)를 포함할 것: 예) 010-3456-2934 </span>
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*대여 도서&nbsp;(기한)
								</dt>
								<dd class="join-form-data">
									<span> <%=bookname %>
									<%if(regnum!=0) { %>
										&nbsp;&nbsp;(<%=m.getReturndate() %>)&nbsp;&nbsp;<a href="returnProc.jsp?regnum=<%=regnum %>" class="return">반납</a>
									<%} else {%>
										<span> 대여도서 없음</span>
									<%} %>
									<%if(i==-1) { %>
										<span class="late">연체 상태</span>
									<%} %>
									</span>
								</dd>
							</dl>
							</form>
						</div>
						
					<div id="buttonLine">
						<input class="modifybutton" type="submit" value="modify" />
						&nbsp;&nbsp;
						<%if(!mid.equals("ADMINISTER")  && regnum==0) { %>
							<a href="memberDelProc.jsp" class="deletebutton">delete</a>
						<%} else if (!mid.equals("ADMINISTER") ) { %>
							<span class="late">(대출도서가 있을 시 회원탈퇴가 불가능합니다.)</span>
						<%} %>
					</div>
				</div>
			</div>
		</section>

</body>
</html>