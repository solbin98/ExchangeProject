package com.project.Controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.Dto.AssetDto;
import com.project.Dto.AssetSearchDto;
import com.project.Dto.CoinOhlcDto;
import com.project.Dto.ContractDto;
import com.project.Dto.OrderBookDto;
import com.project.Service.DataService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	DataService dataservice;

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		// code -> 현재 조회중인 코인의 번호를 저장하는 변수
		String code = "2";
		if(request.getParameter("code") != null) code = request.getParameter("code");
		request.getSession().setAttribute("code", code); // 연결된 사용자의 session 객체에 code 값을 저장
		
		String user_id = (String) request.getSession().getAttribute("id"); // 연결된 사용자의 id 조회
		AssetSearchDto assetDto = new AssetSearchDto(1, user_id); // 사용자의 재산을 조회하기 위한 dto 선언
		AssetDto assetinfo = dataservice.getAsset(assetDto); // 자산 조회 결과를 assetinfo 에 저장
		int coinNumber = Integer.parseInt(code);
		List<ContractDto> contracts = dataservice.getContractList(coinNumber); // 체결된 거래 리스트 불러오기
        List<OrderBookDto> buyside = dataservice.getBuySideOrderBookInfo(coinNumber); // 매수 호가 불러오기
        List<OrderBookDto> sellside = dataservice.getSellSideOrderBookInfo(coinNumber); // 매도 호가 불러오기
        List<CoinOhlcDto> coinOHLC = dataservice.getCoinOhlcList(coinNumber); // 체결 데이터 불러오기
        float price = dataservice.getPrice(Integer.parseInt(code));
        
        model.addAttribute("CoinListInfo", dataservice.getAllCoinList());
		model.addAttribute("Asset_KRW", (assetinfo.getVolume() - assetinfo.getVolume_frozen()));
        model.addAttribute("price_selected_coin", price);
        model.addAttribute("contracts", contracts);
        model.addAttribute("buyside", buyside);
        model.addAttribute("sellside", sellside);
        model.addAttribute("coinOHLC", coinOHLC);
        model.addAttribute("id", request.getSession().getAttribute("id"));
        model.addAttribute("coinNumber", code);
        
		return "home";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {
		logger.info("login 도착, Welcome home! The client locale is {}.", locale);
		return "login";
	}
	

}
