#모듈
#모듈은 함수의 집합이라고 할 수 있다!

#A.py 프로그램에서 func1()함수를 만들어서 사용하는데, B.py 프로그램에서도 func1()함수를 사용하고 싶을 때
#func1()함수를 별도의 파일(ex. Module1.py)에 작성하고, A.py와 B.py 모두 Module1.py를 import해서 사용하면 됨
#Module1.py에는 func1()함수뿐만 아니라 func2(), func3() 등 여러 함수를 추가로 작성해 둘 수 있음

#Module1.py를 먼저 만들어 놓고, A.py와 B.py에서는 import Module1을 사용하면 됨





#1. 모듈 생성 및 사용

#Module1.py 코드
#def func1() :
#    print("Module1.py의 func1()이 호출됨.")

#def func2() :
   # print("Module1.py의 func2()가 호출됨.")

#def func3() :
    #print("Module1.py의 func3()이 호출됨.")


#A.py 코드
import Module1

#메인 코드
Module1.func1()
Module1.func2()
Module1.func3()
#★결과
#Module1.py의 func1()이 호출됨.
#Module1.py의 func2()가 호출됨.
#Module1.py의 func3()이 호출됨.


#+추가
#30~32행에서 Module1.함수명() 형식으로 모듈명을 앞에 붙였는데, 모듈명을 생략하고 함수명만 쓰고 싶을 때
#from 모듈명 import 함수1, 함수2, 함수3 또는 from 모듈명 import * 을 사용하면됨


#B.py 코드
from Module1 import func1, func2, func3 #또는 from Module1 import*

#메인 코드
func1()
func2()
func3()
#★결과
#Module1.py의 func1()이 호출됨.
#Module1.py의 func2()가 호출됨.
#Module1.py의 func3()이 호출됨.





#2. 모듈의 종류
#모듈은 표준 모듈, 사용자 정의 모듈, 서드 파티 모듈로 나눌 수 있음
#표준 모듈 : 파이썬에서 제공하는 모듈
#사용자 정의 모듈 : 직접 만들어서 사용하는 모듈 (위에서 만든 Module1.py)
#서드 파티(3rd Party) 모듈 : 파이썬이 아닌 외부 회사나 단체에서 제공하는 모듈

#파이썬에서 제공하는 모듈 목록 일부 확인하는 법
#import sys
#print(sys.builtin_module_names)

#모듈별로 제공되는 함수 확인하는 법
#dir() 사용
#ex) 수학 계산 모듈인 math 모듈이 제공하는 함수의 목록을 보고싶을 때
#import math
#dir(math)
