<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html lang="ko">
  <head>
    <!-- 부트스트랩 -->
    <!-- CSS only -->
    <link href="./resources/css/MyCss.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
	
</head>


<body style="background-color:1D1A1A; ">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		  <div class="container-fluid">
		    <a class="navbar-brand" href="#">Solbit</a>
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
		      <div class="navbar-nav" style="color:white">
		        <a class="nav-link" href="#">거래소</a>
		        <a class="nav-link" href="#">자산현황</a>
		        <a class="nav-link" href="#">랭킹</a>
		        <a class="nav-link active" href="#">로그인</a>
		        <a class="nav-link" href="#">회원</a>
		      </div>
		    </div>
		  </div>
		</nav>
		
		<div style="width: 100%; height: 100%; display:flex; margin-bottom: 22px; color:white;">
		
			<!--  style="margin-top:150px;margin-left:680px  -->
			<div style="width:100%;margin-top:10px;margin-top:150px;margin-left:680px" >

			
				<form action = "${pageContext.request.contextPath}/loginchk" method="POST" style="width:100%;margin-top:10px">
					<div>
						<dt> 아이디 </dt>
						<input type="text" class="txt" style="height:32px" name="id">
						<dt style="margin-top:8px"> 비밀번호 </dt>
						<input type="password" class="txt" style="height:32px" name="password">
						<br></br>
						<button class="buy_button" style="width:22%"> 로그인 </button>
					</div>
				</form>
				
				<form action = "${pageContext.request.contextPath}/join" method="POST" style="width:100%;margin-top:10px">
					<div >
						<button class="buy_button" style="width:22%"> 회원가입 </button>
					</div>
				</form>

			</div>
		</div>

  </body>
</html>
