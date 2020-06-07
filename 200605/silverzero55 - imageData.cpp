//21812009 조은영
//class 구현부

#include "imageData.h"
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

imageData::imageData(string fname)
{
	ifstream inFile(fname, ios::binary);


	//★영상 헤더 읽기

	getline(inFile, a);
	inFile >> cols >> rows;
	inFile >> maxvalue;


	//★동적 메모리 할당
	pixelValues = new unsigned char[rows * cols * sizeof(unsigned char)]; 
	pixelProcessed = new unsigned char[rows * cols * sizeof(unsigned char)]; 

	inFile.read(reinterpret_cast<char*>(pixelValues), rows * cols * sizeof(unsigned char));
}

int imageData::imageProc(int Mode)
{
	switch (Mode)
	{
	case 0: //image binarization
		for (int row = 0; row < rows; row++)
		{
			for (int col = 0; col < cols; col++)
			{
				if (pixelValues[row * cols + col] > 128)
					pixelProcessed[row * cols + col] = 255;
				else
					pixelProcessed[row * cols + col] = 0;
			}
		}
		break;

	case 1: //image inversion
		for (int row = 0; row < rows; row++)
		{
			for (int col = 0; col < cols; col++)
			{
				pixelProcessed[row * cols + col] = 255 - pixelValues[row * cols + col];
			}
		}
		break;

	case 2: //my image processing method

		for (int row = 0; row < rows; row++)
		{
			for (int col = 0; col < cols; col++)
			{
				pixelProcessed[row * cols + col] = pixelValues[row * cols + col]/2;
				//원본 영상의 데이터 값을 모두 2로 나눠 원본 영상보다 더 어두운 영상을 출력하게 함.
			}
		}

		break;
	}

	return 0;
}

int imageData::imageWrite(string fname)
{
	ofstream outFile(fname, ios::binary);
	outFile << a << endl;
	outFile << cols << ' ' << rows << endl;
	outFile << maxvalue << endl;

	outFile.write(reinterpret_cast<const char*>(pixelProcessed), rows * cols * sizeof(unsigned char));

	outFile.close();

	cout << "영상 저장 완료." << endl;

	return 0;
}

imageData::~imageData(void)
{
	delete[] pixelValues;
	delete[] pixelProcessed;
}
