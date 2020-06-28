#include "pch.h"
#include "majorsimul.h"
#include <iostream>
#include <string>

using namespace std;

majorsimul::majorsimul()
{
	order = 0;
	coefficient = NULL;
	col1 = 0;
	col2 = 0;
	col = 0;
}

void majorsimul::setmajorsimul(int ord)
{
	order = ord;
	col1 = (order + 1) / 2;
	col2 = (order + 1) % 2;
	col = col1 + col2;
	coefficient = new int[(order+1)*col];
}

void majorsimul::setfirstarray(int coef,int rows, int cols)
{
	coefficient[rows * col + cols] = coef;

}

int majorsimul::criterion()
{
	int criterion = 0;
	for (int i = 1; i < order+1; i++)
	{
		if ((coefficient[(i - 1) * col] * coefficient[i * col]) < 0)
			criterion = criterion + 1;
	}

	return criterion;
}

void majorsimul::routharray()
{
	for (int i = 2; i <= order; i++)
	{
		coefficient[i * col + col - 1] = 0;
	}

	for (int i = 2; i <= order; i++)
	{
		for (int j = 0; j < col - 1; j++)
		{
			coefficient[i * col + j] = (-1 / (coefficient[(i - 1) * col])) * ((coefficient[(i - 2) * col] * coefficient[(i - 1) * col + (j + 1)]) - (coefficient[(i - 1) * col] * coefficient[(i - 2) * col + (j + 1)]));
		}
	}
}

majorsimul::~majorsimul()
{
	delete[] coefficient;
}