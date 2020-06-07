//21812009 조은영
//class 선언부

/*
영상처리할 파일을 메모장으로 헤더부분을 확인한 결과
P5
600  677
255
=> 픽셀값들을 읽어오기 전에 위의 헤더를 읽어와야된다!
*/

#pragma once
#include <string>

using namespace std;

class imageData
{
private:
	int rows; //영상의 높이값을 저장함.
	int cols; //영상의 폭 값을 저장함.
	int maxvalue; //255값을 저장하기 위한 멤버 변수 추가 선언.
	string a; //P5를 저장하기 위한 객체 추가 선언.

	unsigned char* pixelValues; 
	//원본 영상으로부터 읽어온 픽셀 값을 저장하기위해 동적메모리를 할당하고, 그 주소를 가리키는 역할을 하는 포인터 변수 .
	unsigned char* pixelProcessed; 
	//영상처리를 한 결과 픽셀 값을 저장하기위해 동적메모리를 할당하고, 그 주소를 가리키는 역할을 하는 포인터 변수.

public:
	imageData(string fname); //생성자 함수, 영상을 읽어오는 역할을 하게 만듦.
	int imageProc(int Mode); //영상처리 수행하는 부분.
	int imageWrite(string fname); //영상처리를 한 결과를 저장하는 부분.
	~imageData(void); //소멸자 함수, 동적 메모리 할당한 것을 지워줌.
};

