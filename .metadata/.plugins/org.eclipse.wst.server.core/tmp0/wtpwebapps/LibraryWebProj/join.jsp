<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/join.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="js/index.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
		//아이디 체크
		$( document ).ready(function(){
			$('#btnCheckUid').click(function(){
				$.ajax({
					type:"POST",
		            url:"idcheck.jsp",
		            dataType:'text',
		            data:{"mid": $('#mid').val()},
		            success:function(data){
		                if($.trim(data) == "YES"){
		                	var ddd = $.trim(data);
		                    alert("사용가능한 아이디입니다.");
		                }else{
		                    alert("이미 존재하는 아이디입니다.");
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
	<!-- header -->
	<jsp:include page="header.jsp"  flush="flase"></jsp:include>
	<section>
	<div id="main">
			<div class="top-wrapper clear">
				<div id="content">
					<form action="joinProc.jsp" method="post" onsubmit="return validate()"> <!-- onsubmit : submit할 때 속성값 확인 -->
						<h2>Join us!!!</h2>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*아이디
								</dt>
								<dd class="join-form-data">
									<!-- required 필수요소 꼭입력받기 pattern 입력받는거 제한해주기-->
									<input type="text" id="mid" name="mid" required placeholder="아이디입력" pattern="[a-zA-Z][a-zA-Z0-9]{3,11}"/><span> 4~12자리 영문자(단,영어로 시작)</span>
									<input id="btnCheckUid" class="button" type="button" value="CHECK" />
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*비밀번호
								</dt>
								<dd class="join-form-data">
									<input type="password" id="pwd" name="pwd" required placeholder="비밀번호입력"/>
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*비밀번호 확인
								</dt>
								<dd class="join-form-data" >
									<input type="password" id="pwd2" name="pwd2" required placeholder="비밀번호재입력"/>
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*이름
								</dt>
								<dd class="join-form-data">
									<input type="text" name="name" required placeholder="이름입력"/>
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*성별
								</dt>
								<dd class="join-form-data">
									<input type="radio" name="gender" value="남자" id="male" checked />남자
	                                <input type="radio" name="gender" value="여자" id="female" />여자
								</dd>
							</dl>
							<dl class="join-form-row birthday">
								<dt class="join-form-title">
									*생년월일
								</dt>
								<dd class="join-form-data">								
	                                <span>
	                                    <input type="text" name="year" id="year" required placeholder="1900" pattern="[12][09][0-9]{2}"/>년
	                                    <input type="text" name="month" id="month"  required placeholder="01" pattern="[01][0-9]"/>월
	                                    <input type="text" name="day" id="day" required placeholder="01" pattern="[0-3][0-9]"/>일
	                                </span>
								</dd>
							</dl>
							<dl class="join-form-row">
								<dt class="join-form-title">
									*핸드폰 번호
								</dt>
								<dd class="join-form-data">
									<input type="text" name="phone" required placeholder="000-0000-0000" pattern="01[016789]-[0-9]{3,4}-[0-9]{4}"/><span> 대시(-)를 포함할 것: 예) 010-3456-2934 </span>
								</dd>
							</dl>				
						</div>
						
					<div id="buttonLine">
						<input class="btn-okay button" type="submit" value="JOIN" />
					</div>
					</form>
				</div>
				
			</div>
		</div>
		</section>

</body>
</html>