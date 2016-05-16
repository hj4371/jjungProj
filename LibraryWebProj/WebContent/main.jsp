<%@page import="com.Library.dao.CommentDAO"%>
<%@page import="com.Library.vo.Comment"%>
<%@page import="com.Library.dao.NoticeDAO"%>
<%@page import="com.Library.vo.Notice"%>
<%@page import="com.Library.dao.BooklistDAO"%>
<%@page import="com.Library.vo.Booklist"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%

	String mid = null;
	if(request.getSession().getAttribute("mid")!=null)  {
		mid = (String)request.getSession().getAttribute("mid");
	}
	
	//call latest page 
	int pages = 1;
	String _pages = request.getParameter("pages");
	if (_pages != null && !_pages.equals("")) {
		pages = Integer.parseInt(_pages);
	}

	List<Notice> nlist = null;
	NoticeDAO ndao = new NoticeDAO();
	nlist = ndao.getNotices(pages, 5);
	
	List<Comment> clist = null;
	CommentDAO cdao = new CommentDAO();
	clist = cdao.getAllComments(pages, 5);
	
	
	BooklistDAO bdao = new BooklistDAO();
	List<Booklist> bsbooks = bdao.getBestSeller();
	List<Booklist> nobooks = bdao.getNewOnes();
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
</head>
<body>
	<!-- header -->
	<% if(mid==null) { %>
	<jsp:include page="header.jsp" flush="flase"></jsp:include>
	<%} else { %>
	<jsp:include page="welcomeheader.jsp" flush="flase"></jsp:include>
	<%} %>
	
	<section>
		<div class="content">
		<form action="searchBook.jsp" method="post">
            	<h1 class="sb_title">SEARCH BOOKS</h1>
                <div id="ui_element" class="sb_wrapper">
                    <div class="sb_element">
						<input class="sb_input" type="search" name="search" required/>
						<input class="sb_search" type="submit" value=""/>
					</div>
					<ul class="sb_dropdown" style="display:none;">
						<li class="sb_filter">Filter your search</li>
						<li><input type="radio" name="filter" value="BOOKNAME" checked/><label for="title">Title</label></li>
						<li><input type="radio" name="filter" value="ISBN"/><label for="ISBN">ISBN</label></li>
						<li><input type="radio" name="filter" value="WRITER"/><label for="writer">Writer</label></li>
						<li><input type="radio" name="filter" value="PUBLISH"/><label for="publish">Publish</label></li>
						<li><input type="radio" name="filter" value="CATEGORY"/><label for="category">Category</label></li>
					</ul>
                </div>
                </form>
        </div>	
           
		<!-- The JavaScript -->
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="js/search.js"></script>
        </section>
        
        <section>
		<article class="content2">
			<div>
				<ul class="notice">
					<table class="article-list">
						<caption class="hidden">
							<a href="notice.jsp">Notice and Request</a>
						</caption>
						<tbody>
							<% for(int i=0; i<nlist.size(); i++) { %>
							<tr>
								<td class="seq1"><%= nlist.get(i).getSeq() %></td>
								<td class="title1"><a href="noticeDetail.jsp?seq=<%=nlist.get(i).getSeq() %>&pages=1"><%= nlist.get(i).getTitle() %></a></td>
								<td class="writer1"><%= nlist.get(i).getWriter() %></td>
								<td class="hit1"><%= nlist.get(i).getHit() %></td>
							</tr>
							<% } %> 
						</tbody>
					</table>
					<ul class="notice">
					<table class="article-list">
						<caption class="hidden">
							<a href="comment.jsp">Comments</a>
						</caption>
						<tbody>
							<% for(int i=0; i<clist.size(); i++) { %>
							<tr>
								<td class="seq2"><%= clist.get(i).getSeq() %></td>
								<td class="title2" ><a href="bookDetail.jsp?regnum=<%=clist.get(i).getRegnum()%>"><%= bdao.getBooklist(clist.get(i).getRegnum()).getBookname() %></a></td>
								<td class="comment2"><%= clist.get(i).getContent() %></td>
								<td class="writer2"><%= clist.get(i).getWriter() %></td>
								
							</tr>
							<% } %> 
						</tbody>
					</table>
				</ul>
			</div>
			<div>
				<ul class="book">
					<li class="booklist"><p>Best Seller</p>
						<% for(int i=0; i<5; i++) { %>
						<a href="bookDetail.jsp?regnum=<%=bsbooks.get(i).getRegnum()%>" title="bs"><img src="images/<%=bsbooks.get(i).getImg() %>" width="80" height="130" alt="title"/></a>
						<% } %>
					</li>
					<li class="booklist2"><p>New Ones</p>
						<% for(int i=0; i<5; i++) { %>
						<a href="bookDetail.jsp?regnum=<%=nobooks.get(i).getRegnum()%>" title="no"><img src="images/<%=nobooks.get(i).getImg() %>" width="80" height="130" alt="title"/></a>
						<% } %>
					</li>
				</ul>
			</div>
		</article>
	</section>

</body>
</html>