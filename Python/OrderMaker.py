import requests
import time
import random

# 자전 거래 봇 코드


# 해당 코드를 실행하면
# "http://localhost:8080/project/echo/show" 주소로
# 랜덤한 지정가 주문이 0.05초 간격으로 전송됩니다.


INF = 1000000
trand = 0 # 추세의 길이를 결정하는 변수
down = 0  # 매수 / 매도 주문을 결정하는 기준값
intense = 0 # 주문의 볼륨 bias
prev_price = 0 # 가장 최근의 시장 가격

for i in range(0, INF):
    if(trand <= 0):
        trand = random.randint(50, 300)  # 추세의 지속 기간
        down = random.randint(0, 100)   # 매수 / 매도 주문을 결정하는 기준값
        intense = random.randint(0, 50) # 주문 볼륨 bias 재설정

    RandomNumber = random.randint(0, 100)    # 매수 / 매도 주문을 결정하는 랜덤값
    volume = random.randint(1, 15) + intense # 주문 수량 = 주문 수량 랜덤값 + 주문의 강도 bias
    price = 0 # 주문할 가격
    type = "" # 주문할 타입

    #randomNumber가 Down 값보다 같거나 작은 경우에, 매도 주문
    if(RandomNumber <= down):
        type = "LS" #지정가 매도
        price = random.randint(1, 100)
        if(prev_price != 0): 
            r = random.randint(-6, 6)
            price = round(prev_price + prev_price * (r/100)) 
            # 이전에 체결되었던 시장가인 prev_price 의 -6% ~ +6% 사이의 가격대로 주문을 생성합니다.

    #randomNumber가 Down 값보다 큰 경우에, 매수 주문
    else:
        type = "LB" #지정가 매수
        price = random.randint(1, 100)
        if(prev_price != 0):
            r = random.randint(-6, 6)
            price = round(prev_price + prev_price * (r/100))
            # 이전에 체결되었던 시장가인 prev_price 의 -6% ~ +6% 사이의 가격대로 주문을 생성합니다.

    #전송할 데이터
    data = {'id' : 'root', 'password' : 'rmsmsrksma1@', 'coin_number' : 2, 'price' : price, 'volume' : volume, 'type' : type}
    ret = requests.post("http://localhost:8080/project/echo/Order", params = data)
    prev_price = float(ret.content) # prev_price를 post 요청 결과의 반환값인 시장 체결가격으로 update 합니다.
    trand-=1 # 남은 추세 기간을 1 빼주고..
    print("현재 남은 추세 기간 : ",trand, " 하락 확률 : ",down)
    time.sleep(0.05)

