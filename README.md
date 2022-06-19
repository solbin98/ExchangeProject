# 💰 가상의 암호화폐 거래소 구현
* 진행중인 프로젝트 입니다.
* 자바와 스프링 프레임워크 / MVC 패턴에 익숙해지고자 시작한 첫 번째 토이 프로젝트입니다.
* 제한된 기능의 가상의 암호화폐 거래소를 구현하는 것을 목표로 합니다.

# 💻  시스템 구성

![system](https://user-images.githubusercontent.com/76681977/174482746-ddb48f1f-3a96-44ed-baed-7f27ce694e6c.png)

## 1) 시스템 기능 목록
구현하고자 하는 기능은 아래와 같습니다.

* 🔴 : 미구현
* 🔵 : 구현 완료
#
* 🔴 로그인
* 🔴  회원가입
* 🔵 차트 인터페이스 
* 🔵 호가창 인터페이스 
* 🔵 지정가 / 시장가 주문 
* 🔵 자전 거래 봇
* 🔴  주문 조회 
* 🔴  랭킹 시스템
* 🔴  서버단 데이터 배치 / 스케쥴링


## 2) 기능 구현 과정

#### 2-1) 로그인
* 로그인은 단순히 DB 입출력과 Session 객체로 임시로 구현했습니다. 
* (추후 수정 할 수도 있고 안 할 수도 있습니다.)

#### 2-2) 회원가입 (미구현)
* 

#### 2-3) 차트 인터페이스 
* 차트 캔버스는 Chart.js 라이브러리의 candle stick chart 를 사용합니다
* 최초로 메인 페이지를 조회하는 순간에 서버단에서 차트 데이터를 받아와서 차트를 그립니다.
* 차트의 업데이트는 하나의 주문이 체결될 때 마다 이루어집니다. 
* 주문이 체결 되면, 주문이 체결된 코인을 조회하고 있는 유저들에게 Socket 핸들러가 체결 데이터를 전송합니다.
* 클라이언트는 소켓이 전송한 체결 데이터 중에서, '가격' 데이터를 활용하여 차트의 종가와 고가, 저가를 업데이트 하여 차트를 다시 그립니다.
* 이런 과정을 반복합니다.


#### 2-4) 호가창 인터페이스 
* 최초로 메인 페이지를 조회하는 순간에 서버단에서 호가 데이터를 받아와서 호가창을 채웁니다.
* 호가창의 업데이트는 하나의 주문이 체결될 때 마다 이루어집니다. 
* 주문이 체결 되면, 주문이 체결된 코인을 조회하고 있는 유저들에게 Socket 핸들러가 호가 데이터를 전송합니다.
* 클라이언트는 소켓이 전송한 호가 데이터를 바탕으로 호가창의 데이터를 변경합니다.
* 시장 가격에 해당하는 블록에만 테두리가 그려집니다.

#### 2-5) 지정가 / 시장가 주문

* 지정가 매수/매도 주문만 구현된 상태입니다. 
* 주문의 처리 순서를 나열하면 다음과 같습니다.

1. 거래소 메인 페이지에서 주문 정보를 작성하고, 전송합니다.
2. 웹 서버단의 WebSocket Handler가 주문을 수신합니다. 핸들러는 OrderMapper 메소드를 통해 주문의 타입에 따라 주문 처리 로직을 분기합니다.
3. 주문 처리 로직은 웹 서버 어플리케이션에서 수행되지 않습니다. Mybatis를 활용하여 Mapper xml 파일에 매핑된 대로, Mysql 내의 프로시저를 호출합니다.

* 프로시저에서 수행하는 주문 매칭 알고리즘은 다음과 같습니다. 
* ( 매수 주문임을 가정합니다. 지금 막 주문한 주문을 새 주문이라 부르고, 기존에 존재하는 주문을 예전 주문이라고 하겠습니다. )
1. 새 주문 가격보다 작거나 같은 예전 주문들을 불러와서, 가격 오름차순(같다면 시간 오름차순)으로 정렬합니다.
2. 정렬된 예전 주문들 하나 하나에 대하여 새 주문의 수량을 모두 소진하거나, 예전 주문들을 모두 소모할때까지 매칭시킵니다.
3. 매칭되는 순간에는 매수, 매도자의 자산 현황과 호가창 데이터가 업데이트 되어야 합니다.
4. 최종적으로 2가지 상태만 남습니다. 새 주문이 사라지거나, 새 주문이 살아남거나.
5. 새 주문이 살아 남는 경우에는, 새로운 호가를 새 주문이 차지합니다. 새로운 가격대에 남은 새 주문의 수량 만큼을 추가해줍니다.


* 해당 과정이 atomic 하게 이루어지지 않으면, 주문을 매칭하는 단계에서 유저의 자산을 업데이트 하는 순간에 동시성 문제가 발생할 수 있었습니다.
* 이를 해결하기 위해 웹 서버 단에서 synchronized 선언을 프로시저를 호출하는 OrderMapper 함수에 걸어놓아서, 프로시저들이 동기적으로 수행되도록 했습니다.

#### 2-6) 자전 거래 봇
* 개발 과정에서 자전 거래 봇이 필요하다는 생각이 들었습니다.
* 자전 거래 봇이 필요한 이유는 다음과 같습니다.
1. 수많은 주문들이 동시에 서버로 전송될 때 주문 체결 알고리즘과 데이터 베이스의 업데이트가 정상적으로 수행되는지 테스트 해야 합니다.
2. 실제 주식/암호화폐 거래소와 같이 역동적인 모습을 재현해보고 싶었습니다.
* 자전 거래 봇의 동작은 아래와 같습니다.
* 봇이 생성하는 주문은 크게 trend, intense, volume, down 이라는 변수의 영향을 받습니다.
* trend는 현재의 추세가 적용되는 기간을 의미합니다. trend는 주문 하나가 전송 될 때 마다 1씩 감소합니다.
* trend가 0이 되는 순간, intense와 down과 trend가 랜덤하게 결정됩니다.
-> intense는 현재의 트렌드에서 한 주문당 기본적으로 체결되는 주문 수량을 의미합니다. 
-> volume은 intense에 더해지는 랜덤한 주문 수량을 의미합니다. 주문 수량 = intense + volume
-> down은 매도 주문이 발생할 확률입니다. 1 - down = 매수 주문 발생 확률 입니다.
* trend가 0 이 되는 순간에 예를 들어 trend가 새롭게 100으로, intense가 50, down이 55로 설정됬다고 가정하면 앞으로 발생할 (trend = 100)개의 주문은 매도 주문이 발생할 확률이 (down = 55%) 이고, 주문 수량은 (intense = 50) 을 기본으로 하고 (1 <= volume <= 14) 값을 더한 값으로 결정된다고 해석할 수 있습니다.


#### 2-7) 주문 조회 (미구현)
*
#### 2-8) 랭킹 시스템 (미구현)
*
#### 2-9) 서버단 데이터 배치 시스템 / 스케쥴러 (미구현)
* 구현 한다면, 아래와 같은 기능들이 필요할 것 같습니다.
* 매분마다 현재 캔들의 시가,종가,저가,고가를 계산해서 차트 데이터 DB에 PUSH 하는 스케쥴러
* 매 30분마다 유저의 랭킹을 계산해주는 스케쥴러 등등...


# 🔥 시연(?)

![호가창](https://user-images.githubusercontent.com/76681977/174486274-883b9577-ce81-47e9-b788-95fa4683b0e8.gif)

* 지정가 주문 처리하는 모습입니다.
* 뭔가 심심합니다.
* 자전 거래 봇을 돌려보겠습니다. 

![자전 거래](https://user-images.githubusercontent.com/76681977/174486390-bfca10e7-9343-480a-9512-5ac7ac6cae59.gif)

* 이렇게요.
* 봇을 돌리면, 서버를 향해 0.05초 간격으로 POST 형식의 주문 데이터를 담은 Request들이 전송됩니다.

![떡상](https://user-images.githubusercontent.com/76681977/174486186-26ff6447-c1b4-4327-b6cb-727ea1b4a5de.gif)

* 주문 생성 봇이 랜덤하게 결정한 추세가 상당히 강한 모양인지, 솔빈코인이 300% 가량 떡상하는 모습입니다. 

![호가창 파트](https://user-images.githubusercontent.com/76681977/174488503-e35b4dfd-32ca-414f-9fb2-6be2ed74b291.gif)

* 호가창도 바쁘게 움직입니다.


# 🔨 개발 환경
### 언어 및 프레임 워크
* Java
*  JavaScript
*  Python
*  Mysql
*  HTML
*  CSS
*  Spring
#
### 환경
* 이클립스
* Tomcat 9.0
* Java-se 1.8
* SpringFramework-Version 5.3.2.RELEASE
