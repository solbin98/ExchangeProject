/**
 * 
 */

var barData;
var prev_pos = 0;
   		
function selectedBlockUpdate(jsondata){
	var now_price = jsondata["price"];
	document.getElementById("buy_block_" + (prev_pos+1) +"_price").style.backgroundColor = "#68A889";
	document.getElementById("sell_block_" + (prev_pos+1) +"_price").style.backgroundColor = "#BD5050";
	for(var i=0;i<jsondata["buyside"].length;i++){
		if(jsondata["buyside"][i]["price"] == now_price){
			var price_element = document.getElementById("buy_block_" + (i+1) +"_price");
			price_element.style.backgroundColor = "#6AC793";
			prev_pos = i;
			break;
		}
	}
	for(var i=0;i<jsondata["sellside"].length;i++){
		if(jsondata["sellside"][i]["price"] == now_price){
			var price_element = document.getElementById("sell_block_" + (i+1) +"_price");
			price_element.style.backgroundColor = "#FF6464";
			prev_pos = i;
			break;
		}
	}
}
   
function contractInfoUpdate(jsondata){
	//contract_info_price_${state.index+1}}	
	for(var i=0;i<jsondata["contracts"].length;i++){
		var price_element = document.getElementById("contract_info_price_" + (i+1));
		var volume_element = document.getElementById("contract_info_volume_" + (i+1));
		var data_element = document.getElementById("contract_info_date_" + (i+1));
		if(jsondata["contracts"][i]["price"] == 0) {
			price_element.textContent = '-';
			volume_element.textContent = '-';
			data_element.textContent = '-';
		} 
		else {
			console.log(jsondata["contracts"][i]['price'], "here");
			console.log(price_element.textContent);
			price_element.textContent = jsondata["contracts"][i]["price"];
			volume_element.textContent = jsondata["contracts"][i]["volume"];
			data_element.textContent = jsondata["contracts"][i]["date_complete"];
		}
	}
}
   
   
function orderBookUpdate(jsondata){
	for(var i=0;i<jsondata["buyside"].length;i++){
		// 매수 호가창 업데이트
		var price_element = document.getElementById("buy_block_" + (i+1) +"_price");
		var volume_element = document.getElementById("buy_block_" + (i+1) +"_volume");
		if(jsondata["buyside"][i]['price'] == 0) {
			price_element.textContent = '-';
			volume_element.textContent = '-';
		}
		else {
			price_element.textContent = jsondata["buyside"][i]['price'];
			volume_element.textContent = jsondata["buyside"][i]['volume'];
		}
	}
	
	for(var i=0;i<jsondata["sellside"].length;i++){
		// 매도 호가창 업데이트
		var price_element = document.getElementById("sell_block_" + (i+1) +"_price");
		var volume_element = document.getElementById("sell_block_" + (i+1) +"_volume");
		if(jsondata["sellside"][i]['price'] == 0) {
			price_element.textContent = '-';
			volume_element.textContent = '-';
		}
		else {
			price_element.textContent = jsondata["sellside"][i]['price'];
			volume_element.textContent = jsondata["sellside"][i]['volume'];
		}
	}
}

function updateCoinOHLC(newPrice){
	var idx = newlist.length-1;
	newlist[idx]['c'] = newPrice;
	if(newlist[idx]['h'] < newPrice) newlist[idx]['h'] = newPrice;
	if(newlist[idx]['l'] > newPrice) newlist[idx]['l'] = newPrice;
	chart.update();
}

function order_UI_clear(){
	$("#order_price").val('');
	$("#order_volume").val('');
	$("#order_quantity").val('');
}

function sendOrder(path, params, method) {
	$.ajax({	type : "POST",	
				url : path, //요청 할 URL	
				data : params,	
				jsonp : "callback",	
				dataType : "JSON",	
				withCredentials: true}
	);
}