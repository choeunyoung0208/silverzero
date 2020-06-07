#리스트와 배열의 차이점
#리스트는 정수, 문자열, 실수 등서로 다른 데이터형도 하나로 묶을 수 있지만 배열은 동일한 데이터형 일때만 묶을 수 있다

#리스트 선언 방법
#1) 빈 리스트를 생성 : 리스트명=[]
#2) 정수로만 구성된 리스트를 생성 : 리스트명 = [값1, 값2, 값3, ... ]    ex) aa=[0, 1, 2]
#3) 문자열로만 구성된 리스트를 생성 : 리스트명 = ['문자1', '문자2', '문자3', ...]    ex) aa=['파이썬', '너무', '재밌다']
#4) 다양한 데이터형을 섞어 리스트를  생성 : 2)와 3)을 활용    ex) aa=[0, 1, '재밌다']

#리스트는 0번 부터 시작함을 잊지말자!





#1. a, b, c, d라는 정수형 변수 4개를 선언한 후 각각의 변수에 값을 입력받고 합계를 출력하는 프로그램 만들기
a=int(input("1번째 숫자(a) : "))
b=int(input("2번째 숫자 : "))
c=int(input("3번째 숫자 : "))
d=int(input("4번째 숫자 : "))

sum=a+b+c+d

print("합계 : %d" % sum)
#★결과
#1번째 숫자(a) : 10
#2번째 숫자 : 20
#3번째 숫자 : 30
#4번째 숫자 : 40
#합계 : 100





#2. 위의 프로그램을 리스트를 사용해서 만들기
#aa=[0, 1, 2, 3]이라는 리스트에서 리스트의 첫번째 값은 aa[1]이 아니라 aa[0]
aa=[0, 0, 0, 0]

aa[0]=int(input("1번째 숫자(aa[0]) : "))
aa[1]=int(input("2번째 숫자 : "))
aa[2]=int(input("3번째 숫자 : "))
aa[3]=int(input("4번째 숫자 : "))

sum1=aa[0]+aa[1]+aa[2]+aa[3]

print("합계 : %d" % sum1)
#★결과
#1번째 숫자(aa[0]) : 20
#2번째 숫자 : 30
#3번째 숫자 : 40
#4번째 숫자 : 50
#합계 : 140





#3. 위의 프로그램(#2)을 반복문을 사용해서 만들기
#빈 리스트를 생성한 뒤,  리스트명.append(값) 명령어를 사용해서 리스트 확장
bb=[]
sum2=0

for i in range(1, 5, 1) : #for i in range(1, 5) : 와 똑같은 명령어
    bb.append(0)

len(bb) #len(리스트) : 리스트의 개수를 확인할 수 있는 명령어

for i in range(1, 5, 1) :
    bb[i-1]=int(input(str(i) + "번째 숫자 : ")) #str(i) : 숫자(i)를 문자로 변환 후 "번째 숫자 : "와 합침

for i in range (1, 5, 1) :
    sum2=sum2+bb[i-1]

print("합계 : %d" % sum2)
#★결과
#1번째 숫자 : 100
#2번째 숫자 : 200
#3번째 숫자 : 300
#4번째 숫자 : 400
#합계 : 1000





#4. 리스트가 100개인 cc를 생성한 뒤, 2의배수(0, 2, 4, 8...)로 초기화한 후 리스트 dd에 역순으로 넣기
cc=[]
dd=[]
#value=0

for i in range(0, 100, 1) :
    cc.append(0)
    cc[i]=2*i  #cc. append(0), cc[i]=2*i 대신에 다른 명령어로도 구현 가능
    #cc.append(value)
    #value += 2

for i in range(0, 100, 1) :
    dd.append(0)
    dd[i]=cc[99-i] #dd.append(0), dd[i]=cc[99-i] 대신에 다른 명령어로도 구현 가능
    #dd.append(cc[99-i])

print("dd[0]에는 %d, dd[99]에는 %d 출력" % (dd[0], dd[99]))
#★결과
#dd[0]에는 198, dd[99]에는 0 출력




#5. 리스트 값에 접근하기
ee=[10, 20, 30, 40]
print("ee[-1]은 %d, ee[-2]는 %d" % (ee[-1], ee[-2])) #ee[-1]은 리스트 ee의 제일 마지막 값, ee[-2]는 ee[-1]의 이전 값이 출력됨
#★결과
#ee[-1]은 40, ee[-2]는 30

#colon을 사용해 리스트 안의 여러 값들을 동시에 출력하기 가능. 리스트명[시작값:끝값+1] 명령어 사용
print("ee[0:4] 출력 결과 : %s" % ee[0:4]) #ee[0]부터 ee[3]까지 출력.
print("ee[-1:-2] 출력 결과 : %s" % ee[-1:-2] )
#★결과
#ee[0:4] 출력 결과 : [10, 20, 30, 40]
#ee[-1:-2] 출력 결과 : []

#colon의 앞이나 뒤의 숫자를 생략해서 사용하기도 가능
print("ee[2:] 츨력 결과 : %s" % ee[2:]) #ee[2]부터 끝까지 출력
print("ee[:2] 출력 결과 : %s" % ee[:2]) #ee[0]부터 ee[1]까지 출력
print("ee[-1:] 출력 결과 : %s" % ee[-1:])
print("ee[:-1] 출력 결과 : %s" % ee[:-1])
#★결과
#ee[2:] 츨력 결과 : [30, 40]
#ee[:2] 출력 결과 : [10, 20]
#ee[-1:] 출력 결과 : [40]
#ee[:-1] 출력 결과 : [10, 20, 30]





#6. 리스트끼리 덧셈, 곱셈 연산
#덧셈 연산 : 리스트명1 + 리스트명2
#곱셈 연산 : 리스트명 * 숫자
ff=[10, 20, 30]
gg=[40, 50, 60]
print("%s" % (ff+gg)) #리스트의 요소들이 합쳐져 하나의 리스트가 됨
print("%s" % (ff+ff))
print("%s" % (ff*5)) #리스트의 요소들이 횟수만큼 반복해서 출력됨
#★결과
#[10, 20, 30, 40, 50, 60]
#[10, 20, 30, 10, 20, 30]
#[10, 20, 30, 10, 20, 30, 10, 20, 30, 10, 20, 30, 10, 20, 30]





#7. 리스트의 항목을 건너뛰면서 추출
#리스트명[::2] : 앞에서부터 2칸씩 건너뛰라는 의미
#리스트명[::-2] : 뒤에서부터 2칸씩 건너뛰라는 의미
#리스트명[::-1] : 리스트를 거꾸로 출력함
#리스트명[1::2] : 첫 번째부터 2칸씩 건너뛰라는 의미
hh=[10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
print("%s" % hh[::2])
print("%s" % hh[::-2])
print("%s" % hh[::-1])
print("%s" % hh[1::3])
#★결과
#[10, 30, 50, 70, 90]
#[100, 80, 60, 40, 20]
#[100, 90, 80, 70, 60, 50, 40, 30, 20, 10]
#[20, 50, 80]





#8. 리스트의 값을 변경
ii=[10, 20, 30]
ii[1]=200
print("%s" % ii)
#★결과
#[10, 200, 30]

jj=[10, 20, 30]
jj[1:2]=[200, 201] #jj[1:2]=jj[1]을 의미. jj[1]의 값을 200, 201로 변경
print("%s" % jj)
#★결과
#[10, 200, 201, 30]

#jj[1:2]=jj[1]인데, jj[1]을 사용해보면
kk=[10, 20, 30]
kk[1]=[200, 201] #리스트 안에 또 다른 리스트가 추가되는 결과가 나타남
print("%s" % kk)
#★결과
#[10, [200, 201], 30]





#9. 리스트의 요소를 삭제
#한 개의 요소만 삭제할 경우 : del()함수 사용. del(리스트명[삭제하고자 하는 위치])
#ex) aa=[10, 20, 30]에서 20을 삭제하고 싶을 경우, del(aa[1])
#여러 개의 요소를 삭제할 경우 : 리스트명[시작값:끝값+1]=[] 사용
#ex) aa=[10, 20, 30]에서 10, 20을 삭제하고 싶을 경우, aa[0:2]=[]
ll=[10, 20, 30]
del(ll[0])
print("%s" % ll)
#★결과
#[20, 30]

mm=[10, 20, 30]
mm[0:3]=[] #리스트 안의 요소들이 모두 삭제됨
print("%s" % mm)
#★결과
#[]


#리스트 내용을 모두 삭제해 빈 리스트로 만드는 또다른 방법 : mm=[]

mm=None #리스트에 None값을 넣으면 mm을 빈 변수로 만들 수 있음.
#★결과 : 아무것도 안 나옴





#여러가지 리스트 조작 함수들 정리
#함수, 설명, 사용법 순
#1) append(), 리스트 맨 뒤에 요소를 추가 , 리스트명.append(값)
#2) pop(), 리스트 맨 뒤의 요소를 빼냄(리스트에서 해당 항목이 삭제됨), 리스트명.pop()
#3) sort(), 리스트의 요소를 정렬, 리스트명.sort()
#4) reverse(), 리스트 요소들의 순서를 역순으로 만듦, 리스트명.reverse()
#5) index(), 지정한 값을 찾아 해당 위치를 반환, 리스트명.index(찾을값)
#6) insert(), 지정된 위치에 값을 넣음, 리스트명.insert(위치, 값)
#7) remove(), 리스트에서 지정한 값을 삭제함. 지정한 값이 여러 개면 첫번째 값만 지움, 리스트명.remove(지울값)
#8) extend(), 리스트 뒤에 리스트를 추가함. 리스트의 덧셈 연산과 동일한 기능, 리스트명.extend(추가할리스트)
#9) count(), 리스트에서 해당 값의 개수를 셈, 리스트명.count(찾을값)
#10) clear(), 리스트의 내용을 모두 지움, 리스트명.clear()
#11) del(), 리스트에서 해당 위치의 요소를 삭제함, del(리스트명[위치])
#12) len(), 리스트에 포함된 전체 요소의 개수를 셈, len(리스트명)
#13) copy(), 리스트의 내용을 새로운 리스트에 복사, 새 리스트=리스트명.copy()
#14) sorted(), 리스트의 요소를 정렬해서 새로운 리스트에 대입, 새 리스트= sorted(리스트명)





#10. 여러가지 리스트 조작 함수들 이용해보기
b=[30, 10, 20]
c=[111, 111, 1110]

print("현재 리스트 : %s" % b)
#★결과
#현재 리스트 : [30, 10, 20]

b.append(20)
print("append(20) 후의 리스트 : %s" % b)
#★결과
#append(20) 후의 리스트 : [30, 10, 20, 20]

print("pop 사용 결과 : %d" % b.pop())
#★결과
#pop 사용 결과 : 20

print("pop 후의 리스트 : %s" % b)
#★결과
#pop 후의 리스트 : [30, 10, 20]

b.sort()
print("sort 후의 리스트 : %s" % b)
#★결과
#sort 후의 리스트 : [10, 20, 30]

b.reverse()
print("reverse 후의 리스트 : %s" % b)
#★결과
#reverse 후의 리스트 : [30, 20, 10]

print("index(20) 사용 결과 : %d" % b.index(20))
#★결과
#index(20) 사용 결과 : 1

b.insert(2, 30)
print("insert(2, 30) 후의 리스트 : %s" % b)
#★결과
#insert(2, 30) 후의 리스트 : [30, 20, 30, 10]

b.remove(20)
print("remove(20) 후의 리스트 : %s" % b)
#★결과
#remove(20) 후의 리스트 : [30, 30, 10]

b.extend(c)
print("extend(c)후의 리스트 : %s" % b)
#★결과
#extend(c)후의 리스트 : [30, 30, 10, 111, 111, 1110]

print("count(111) 사용 결과 : %d" % b.count(111))
#★결과
#count(111) 사용 결과 : 2

del(b[0])
print("del(0) 후의 리스트 : %s" % b)
#★결과
#del(0) 후의 리스트 : [30, 10, 111, 111, 1110]

print('len(a) 사용 결과 : %d' % len(b))
#★결과
#len(a) 사용 결과 : 5

d=b.copy()
print("copy를 사용해 만든 새 리스트 : %s" % d)
#★결과
#copy를 사용해 만든 새 리스트 : [30, 10, 111, 111, 1110]

e=sorted(b)
print("sorted를 사용해 만든 새 리스트 : %s" % e)
#★결과
#sorted를 사용해 만든 새 리스트 : [10, 30, 111, 111, 1110]





#200211
#리스트 a=[10, 20, 30] 출력
#1) print("%s" % a)
#2) print(a)
