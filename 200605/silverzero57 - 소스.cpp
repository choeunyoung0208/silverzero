//21812009 조은영

#include <iostream>
#include <fstream>
#include <string>
#include "imageData.h"

using namespace std;

int main()
{
	string input_name; //영상처리할 파일명을 저장하기위해 string class를 이용해 객체 생성.
	string output_name; //영상처리 결과를 파일로 저장하기위해 string class를 이용해 객체 생성.
	int mode; //사용자로부터 원하는 영상처리 방식을 입력받은 값을 저장할 변수 생성.

	cout << "21812009 조은영" << endl;

	cout << "영상처리할 파일명을 입력해주세요. (예 : test.pgm) : ";
	getline(cin, input_name); //사용자로부터 입력받은 문자열을 input_name에 저장.

	imageData imageprocessing(input_name); //imageData class를 사용해 객체 생성. 
	//input_name은 생성자 함수 imageData의 argument.

	cout << "영상처리할 종류를 선택해주세요. (0 : Binarization, 1 : Inversion, 2 : My image processing method) : ";
	cin >> mode; //사용자로부터 입력받은 값을 mode에 저장.
	imageprocessing.imageProc(mode); //내가 만든 객체의 멤버함수를 사용하여 영상처리. 
	//mode는 imageProce의 argument.

	cout << "저장할 파일명을 입력해주세요. (예 : test.pgm) : ";
	cin.ignore(); 
	//buffer pointer가 \n를 가리키는 것을 cin.ignore()를 사용하여 포인터가 다음 공간을 가리키게 만듦.
	getline(cin, output_name); //사용자로부터 입력받은 문자열을 output_name에 저장.
	imageprocessing.imageWrite(output_name); //내가 만든 객체의 멤버함수를 사용하여 영상 저장.
	//output_name은 imageWrite의 argument.

	return 0;
}
