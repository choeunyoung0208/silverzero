#pragma once
#include <string>

class majorsimul
{
private:
	int order; //특성방정식 차수
	int* coefficient; //Routh array의 값 저장
	int col1; 
	int col2;
	int col; //Routh array의 column

public:
	majorsimul(); //생성자 함수
	void setmajorsimul(int ord);
	void setfirstarray(int coef, int rows, int cols);
	void routharray();
	int criterion();
	~majorsimul(); //소멸자 함수
};

