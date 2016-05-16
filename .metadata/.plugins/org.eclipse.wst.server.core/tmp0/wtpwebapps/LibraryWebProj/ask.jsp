<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String mid = null;
	if (request.getSession().getAttribute("mid") == null) {
		request.getSession().setAttribute("returnURL", "/books.jsp");
		response.sendRedirect("login.jsp");
	} else {
		mid = (String) request.getSession().getAttribute("mid");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>library project_sung</title>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="js/index.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
		//아이디 체크
		$( document ).ready(function(){
			$('#btnCheckUid').click(function(){
				$.ajax({
					type:"POST",
		            url:"bookcheck.jsp",
		            dataType:'text',
		            data:{"bookname": $('#bookname').val()},
		            success:function(data){
		                if($.trim(data) == "YES"){
		                	var ddd = $.trim(data);
		                    alert("접수 가능합니다.");
		                }else{
		                    alert("이미 존재하는 도서입니다.");
		                }
		            }
		        });    
		    });
		});
		
		//비밀번호 체크
		function validate(){
			if( $('#pwd').val() != $('#pwd2').val() ) {
				alert("비밀번호가 다릅니다. 확인해주세요.");
				return false;
			}
		}
		
		
</script>
</head>
<body>
	<% if (mid == null) { %>
	<jsp:include page="header.jsp" flush="flase"></jsp:include>
	<% } else { %>
	<jsp:include page="welcomeheader.jsp" flush="flase"></jsp:include>
	<% } %>

	<section>
	<div id="ask">
			<div class="top-wrapper clear">
				<div id="content">
					<form action="askProc.jsp" method="post" onsubmit="return validate()"> <!-- onsubmit : submit할 때 속성값 확인 -->
						<h2>Ask new Ones</h2>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*도서 이름
								</dt>
								<dd class="join-form-data">
									<input type="text" id="bookname" name="bookname" required placeholder="도서입력" />
									<input id="btnCheckUid" class="button" type="button" value="CHECK" />
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*저자
								</dt>
								<dd class="join-form-data">
									<input type="text" name="writer" required placeholder="저자입력"/>
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*출판사
								</dt>
								<dd class="join-form-data">
									<input type="text" name="publish" required placeholder="출판사입력"/>
								</dd>
							</dl>
						</div>
						
					<div id="buttonLine">
						<input class="btn-okay button" type="submit" value="접수" />
					</div>
					</form>
				</div>
				
			</div>
		</div>
		</section>

</body>
</html>