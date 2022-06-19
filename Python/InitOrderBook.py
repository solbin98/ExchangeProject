import pymysql
import random 

#호가창을 초기화 하기 위한 코드입니다.
#root 계정으로 1원 부터 59원 까지의 지정가 매수 주문을, 60원 부터 119원 까지의 지정가 매도 주문을 걸어줍니다.

conn = pymysql.connect(host = 'localhost', user = 'root', password = '232423e', database = 'mydb', port = 3306)
cursor = conn.cursor()
coin_number = '2'

def send_order(type, price):
    volume = random.randint(20,100)
    query = "insert into order_table values(0," + str(price) + "," + str(volume) + "," + str(volume) + ",'" + type + "','','root'," + coin_number + ");" 
    print("first : ", query)
    cursor.execute(query)
    query = "call UpdateOrderBook("+coin_number+","+str(price)+","+str(volume)+",'"+type+"');"
    cursor.execute(query)
    print("second : ",query)

for i in range(1, 60):
    send_order("LB", i)
for i in range(61, 120):
    send_order("LS", i)

conn.commit()