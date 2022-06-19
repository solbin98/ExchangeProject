<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
  <head>
    <!-- 부트스트랩 -->
    <!-- CSS only -->
    <link href="./resources/css/myStyle.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/luxon@1.26.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.0.1/dist/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-luxon@1.0.0"></script>
	<script type="text/javascript" src="./resources/js/chartjs-chart-financial.js"></script>
	<script type="text/javascript" src="./resources/js/order-logic.js"></script>
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
		        <a class="nav-link active" href="home">거래소</a>
		        <a class="nav-link" href="#">자산현황</a>
		        <a class="nav-link" href="#">랭킹</a>
		        <a class="nav-link" href="login">로그인</a>
		        <a class="nav-link" href="#">회원</a>
		      </div>
		    </div>
		  </div>
		</nav>
	
	<div style="width: 100%; height: 100%; display:flex; margin-bottom: 22px;">
		<!-- 차트 / 호가 / 주문 레이아웃 -->
		<div style="width: 93%; height: 100%;">
		<!--  gray-> #535151 dark -> # 2F2F31 -->
			<!-- 차트 레이아웃 -->
			<div style="background-color:#2F2F31 ; width: 93%; height: 550px; margin-top: 25px; margin-left: 22px;">
				<!-- 차트 헤더 레이아웃 -->
				<div style="background-color:#535151 ; width: 100%; height: 45px;"> </div>
				<div style="width:95%;height:80%">
				  <canvas id="chart"></canvas>
				</div>
			</div>
			
			<!-- 호가창 및 주문 레이아웃 -->
			<div style="width: 93%; height: 800px; margin-top: 25px; margin-left: 22px; display:flex;">
				<!-- 호가창 -->
				<div style="background-color:#2F2F31; width: 55%; height: 100%; ">
					<div style="width: 100%; height: 25px; display:flex; "> 					
						<div style ="color: white; width:50%; margin-left:100px"> 가격 </div>
						<div style ="color: white; width:20%"> 거래량 </div>
					</div>
					
					<!-- Sell side -->
					<div style="width: 100%; height: 46%;margin-top:15px;display:flex;flex-direction: column;justify-content:flex-end;"> 
						<table class = "sell_side_block" style="width:100%" id = "SellSideTable">
							<c:forEach items="${sellside}" var = "list" varStatus="state">
								<c:if test="${list.price != 0}">
									<tr id = "sell_block_${state.index + 1}"> 
										<td class="sell_side_price_volume_block" id = "sell_block_${state.index + 1}_price"> ${list.price} </td>
										<td class="sell_side_price_volume_block" id = "sell_block_${state.index + 1}_volume"> ${list.volume} </td>
									</tr>
								</c:if>
								
								<c:if test="${list.price == 0}">
									<tr id = "sell_block_${state.index + 1}"> 
										<td class="sell_side_price_volume_block" id = "sell_block_${state.index + 1}_price"> - </td>
										<td class="sell_side_price_volume_block" id = "sell_block_${state.index + 1}_volume"> - </td>
									</tr>
								</c:if>
							</c:forEach>
						</table>
					</div>
					
					<!-- Buy side -->
					<div style="width: 100%; height: 50%;"> 
						<table class = "buy_side_block" style="width:100%" id = "BuySideTable">
							<c:forEach items="${buyside}" var = "list" varStatus="state">
								<c:if test="${list.price != 0}">
									<tr id = "buy_block_${state.index + 1}"> 
										<td class="buy_side_price_volume_block" id = "buy_block_${state.index + 1}_price"> ${list.price} </td>
										<td class="buy_side_price_volume_block" id = "buy_block_${state.index + 1}_volume"> ${list.volume} </td>
									</tr>
								</c:if>
								
								<c:if test="${list.price == 0}">
									<tr id = "buy_block_${state.index + 1}"> 
										<td class="buy_side_price_volume_block" id = "buy_block_${state.index + 1}_price"> - </td>
										<td class="buy_side_price_volume_block" id = "buy_block_${state.index + 1}_volume"> - </td>
									</tr>
								</c:if>
							</c:forEach>
						</table>
					</div>

				</div>
				
				<div style="width: 45%; height: 100%; margin-left: 25px; color: white">
					<!-- 주문 -->
					<div style="background-color:#2F2F31; width: 100%; height: 50%; color: white">
						<div style="width: 100%; height: 10%; display:flex"> 					
								<div style ="width:50%; margin-left:75px"> 지정가 </div>
								<div style ="width:20%"> 시장가 </div>
							</div>
							<div class = "order_layout" style="background-color:#2F2F31; width: 90%; height:80%; margin-left: 20px;">
								<dt> 보유 현금 </dt>
								<input type="text" class="txt" value="<%= request.getAttribute("Asset_KRW") %>" disabled>
								
								<dt style="margin-top:8px;"> 가격 </dt>
								<input id = "order_price" type="text" class="txt" value="100">
								
								<dt style="margin-top:8px"> 수량 </dt>
								<input id = "order_volume" type="text" class="txt" value="0.5">
								
								<dt  style="margin-top:8px"> 주문 총액  </dt>
								<input id = "order_quantity" type="text" class="txt" value="50원" disabled>
							
								<br></br>
								
								<div style="width:100% ; display:flex;margin-top:30px" >
									<input type="button" id="limit_buy_order" class="buy_button" style="width:50%" value = "BUY"> </button>
									<input type="button" id="limit_sell_order" class="sell_button" style="width: 50%" value = "SELL"> </button>
								</div>
		
							</div>
					</div>
					
					<!-- 체결 내역 -->
					<div style="background-color:#2F2F31; width: 100%; height: 46%; margin-top: 25px; color: white">
						<div style="width: 100%; height: 10%; display:flex"> 					
							<div style ="width:33%; margin-left:75px"> 체결가 </div>
							<div style ="width:33%"> 체결수량 </div>
							<div style ="width:33%"> 체결시각 </div>
						</div>
						
						<table id="order_history_table" style="width:100%; height:90%">
							<c:forEach items="${contracts}" var = "list" varStatus="state" >
								<tr class="coin_info_table"> 
									<td class = "contract_info_block" id = "contract_info_price_${state.index+1}"> ${list.price} </td>
									<td class = "contract_info_block" id = "contract_info_volume_${state.index+1}"> ${list.volume} </td>
									<td class = "contract_info_block" id = "contract_info_date_${state.index+1}"> ${list.date_complete} </td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				
			</div>
			
		</div>
		
		<div style="width: 27%; height: 100%; margin-right:35px">
			<!-- 코인 리스트  -->
			<div style="background-color:#2F2F31 ; width: 100%; height: 100%; margin-top: 25px;">
				<!-- 코인 리스트 헤더 -->
				<div style="background-color:#535151 ; width: 100%; height: 25px; color:white;text-align:center"> 코인 리스트 </div>
				<!-- 코인 리스트 헤더(정보) -->
				<div class="coin_info_table"> 
					<p class = "coin_info_block"> 이름 </p>
					<p class = "coin_info_block"> 현재 가격 </p>
					<p class = "coin_info_block"> 등락 </p>
				</div>	
				
				<!-- 코인 리스트   -->
				<table id = "coin-list" style="width:100%">
						<c:forEach items="${CoinListInfo}" var = "list">
							<tr class = "coin_block_up" onclick="location.href='?code=${list.coin_number}'">
								<td class = "coin_info_block" ><c:out value="${list.name}" /></td>
								<td class = "coin_info_block" id = "coin_info_block_price_${list.coin_number}"><c:out value="${list.price}" /></td>
								<td class = "coin_info_block" id = "coin_info_block_diff_${list.coin_number}"><c:out value="" /></td>
							</tr>
						</c:forEach>
				</table>
			</div>
		</div>
	</div>

  </body>
  
   <script type="text/javascript">
   		var prev = 60;
   		function priceUpdate(jsondata){
   			var number = jsondata['coinNumber'];
   			var jstr = jsondata['coinNumber'];
   			var percent = (100.0 * (jsondata['price'] - prev) / prev);
   			percent = percent.toFixed(2);
   			
   			console.log("here~ " + 'coin_info_block_price_'+number);
   			document.getElementById('coin_info_block_price_'+number).textContent = jsondata['price'];
   			document.getElementById('coin_info_block_diff_'+number).textContent = percent + "%";
   		}
   
		$("#limit_buy_order").click(function() {
			params = {"id" : "${id}", "coin_number": "${coinNumber}","price" : $("#order_price").val(), "volume" : $("#order_volume").val(), "type" : "LB"};
			console.log(params);
			sendOrder("http://localhost:8080/project/echo/Order", params);
			order_UI_clear();
		});
		
		$("#limit_sell_order").click(function() {
			params = {"id" : "${id}", "coin_number": "${coinNumber}", "price" : $("#order_price").val(), "volume" : $("#order_volume").val(), "type" : "LS"};
			sendOrder("http://localhost:8080/project/echo/Order",params);
			order_UI_clear();
		});
	
		let sock = new SockJS("http://localhost:8080/project/echo/");
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		
		// 주문 전송
		function sendMessage(type) {
			alert('Lorem ipsum dolor');
			var t = {"price" : $("#order_price").val(), "volume" : $("#order_volume").val(), "type" : type};
			sock.send(JSON.stringify(t));
		}
		
		var chart;
		var newlist = [];
		var ctx = document.getElementById('chart').getContext('2d');
		ctx.canvas.width = 500;
		ctx.canvas.height = 250;
		
		// 서버로부터 메시지를 받았을 때
		function onMessage(msg) {
			var jsondata = JSON.parse(msg.data);
			console.log(jsondata);
			if(jsondata['type'] == "orderbook_and_price"){ // 거래가 체결될 때 마다 전송되는, 업데이트를 위한 메시지인 경우
				// order-logic.js 참조
				priceUpdate(jsondata);
				orderBookUpdate(jsondata);
				contractInfoUpdate(jsondata);
				selectedBlockUpdate(jsondata);
				updateCoinOHLC(jsondata['price']);
			}
			else if(jsondata['type'] == "ohlc"){ // 소켓 연결이 성공한 다음 전송되는, 차트 업데이트를 위한 캔들스틱 데이터인 경우
				barData = jsondata['coinOHLC'];
				var barCount = 100;
				for(var i=0;i<barData.length;i++){
					var ndate = luxon.DateTime.fromSQL(barData[i]['date']);
					ndate = ndate-1;
					newlist.push({'x' : ndate, 'o' : barData[i]['open'], 'h' :barData[i]['high'], 'l' : barData[i]['low'], 'c' : barData[i]['close']});
				}
				chart = new Chart(ctx, {
					type: 'candlestick',
					data: {
						datasets: [{
							label: 'CHRT - Chart.js Corporation',
							data: newlist
						}]
					}
				});
				
				newlist.color = {
					up: '#01ff01',
					down: '#fe0000',
					unchanged: '#999',
				};
			}
		}
		
		// 서버와 연결을 끊었을 때
		function onClose(evt) {
			$("#messageArea").append("연결 끊김");
		}
		
	</script>
</html>
