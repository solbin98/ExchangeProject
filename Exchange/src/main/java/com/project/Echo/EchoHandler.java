package com.project.Echo;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;


import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.project.Dto.ContractDto;
import com.project.Dto.OrderBookDto;
import com.project.Dto.OrderInfoDto;
import com.project.Service.DataService;
import com.project.Service.OrderService;

@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler{
    // 접속한 회원들을 관리하기 위한 List 객체
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);

	@Autowired
    OrderService orderService;
    
    @Autowired
    DataService dataService;
    
    //클라이언트가 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessionList.add(session); 
        JSONObject newMessage = new JSONObject(); // 연결이 완료된 사람들에게 전송할 메시지
        Map<String, Object> userData = session.getAttributes();
        
        int coinNumber = Integer.parseInt((String) userData.get("code"));
        newMessage.put("coinOHLC", dataService.getCoinOhlcList(coinNumber)); // 코인 차트 데이터 newMessage에 담기
        newMessage.put("type", "ohlc");
        
        session.sendMessage(new TextMessage(newMessage.toString())); // 연결자에게 message 전달
    }

    //클라이언트가 웹소켓 서버로 주문을 전송했을 때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	
    }
    
    //클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getId());
    }
    
    // 오더의 원자성을 보장하기 위해 synchronized 선언
	public synchronized float OrderMapper(OrderInfoDto orderInfodto) {
		return orderService.OrderMapper(orderInfodto);
	}
	
    @ResponseBody
    @RequestMapping("/Order")
    public float function(  @RequestParam(value="id") String id, 
    					    @RequestParam(value="coin_number") int coinNumber, 
    					    @RequestParam(value="price") float price,
    					    @RequestParam(value="volume") float volume,
    					    @RequestParam(value="type") String type) throws IOException {
    	
        OrderInfoDto orderInfodto = new OrderInfoDto(price, volume, type, getCurrentDateTime(), id, coinNumber);
        float marketPrice = OrderMapper(orderInfodto);
        SendDataToAllUsers(coinNumber, marketPrice);
        return marketPrice;
    }
	
	public void SendDataToAllUsers(int coinNumber, float marketPrice) throws IOException {
		List<OrderBookDto> buyside = dataService.getBuySideOrderBookInfo(coinNumber);
        List<OrderBookDto> sellside = dataService.getSellSideOrderBookInfo(coinNumber);
        //모든 유저에게 메세지 출력
        for(WebSocketSession sess : sessionList){
        	JSONObject newMessage = new JSONObject();
        	
        	Map<String, Object> sessData = sess.getAttributes();
        	if(sessData.get("code").equals(Integer.toString(coinNumber))) {
        			// 현재 주문 체결된 코인을 조회하고 있는 사용자들에게 호가 데이터 및 체결 데이터 업데이트 데이터 전달
        			List<ContractDto> contracts = dataService.getContractList(coinNumber);
	                newMessage.put("buyside",buyside);
        			newMessage.put("sellside",sellside);
        			newMessage.put("contracts", contracts);
        			newMessage.put("type", "orderbook_and_price");
        	}
        	else newMessage.put("type", "only_price");
        	newMessage.put("price", marketPrice);
        	newMessage.put("coinNumber", coinNumber);
        	sess.sendMessage(new TextMessage(newMessage.toString()));
        }
	}
	
    public static String getCurrentDateTime() {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "yyyy-MM-dd HH:mm:ss"; //hhmmss로 시간,분,초만 뽑기도 가능
		SimpleDateFormat formatter = new SimpleDateFormat(pattern,
				currentLocale);
		return formatter.format(today);
	}
}