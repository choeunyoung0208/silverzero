#pragma once
#include <string>

class majorsimul
{
private:
	int order; //Ư�������� ����
	int* coefficient; //Routh array�� �� ����
	int col1; 
	int col2;
	int col; //Routh array�� column

public:
	majorsimul(); //������ �Լ�
	void setmajorsimul(int ord);
	void setfirstarray(int coef, int rows, int cols);
	void routharray();
	int criterion();
	~majorsimul(); //�Ҹ��� �Լ�
};

