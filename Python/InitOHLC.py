import pymysql
import random
import datetime

# 100개의 랜덤한 캔들을 만들기 위한 코드입니다.

host = "localhost"
port = "3306"
database = "mydb"
username = "root"
password = "232423e"

conn = pymysql.connect(host='localhost', user='root', password='232423e', db='mydb', charset='utf8')
cursor = conn.cursor()


dt = datetime.datetime.now() - datetime.timedelta(minutes=100)
pricelist = []
cprice = 100
oprice = cprice
lprice = cprice
hprice = cprice

for i in range(0, 100):
    for j in range(0, 15): 
        randint = random.randrange(0, 2)
        if(randint == 0): cprice -= 1
        else : cprice += 1
        lprice = min(lprice, cprice)
        hprice = max(hprice, cprice)

    dstr = dt.strftime("%Y-%m-%d %H:%M:00")
    dt = dt + datetime.timedelta(minutes=1)
    tlist = [2, oprice, cprice, lprice, hprice, 0, dstr]
    lprice = cprice
    hprice = cprice
    oprice = cprice
    pricelist.append(tlist)

for i in range(0, len(pricelist)):
    list = pricelist[i]
    query = "insert into coin_ohlc_store values(" + str(2) + "," + str(list[1]) + "," + str(list[2]) + "," + str(list[3]) + "," + str(list[4]) + "," + str(list[5]) + ",'" + str(list[6]) + "');"
    print(query)
    cursor.execute(query)
    conn.commit()