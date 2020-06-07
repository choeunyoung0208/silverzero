//21812009 조은영
#include <iostream> //키보드, 모니터의 입출력을 담당하는 iostream 클래스를 불러옴.
#include <string> //문자열 데이터를 사용하기 위해 string 클래스(또는 라이브러리 라고함)를 불러옴.
#include <fstream> //파일 입출력(읽기, 쓰기)을 담당하는 fstream 클래스를 불러옴.

using namespace std;

void readImage(string fname, unsigned char* a, unsigned char* b, int* c, int* d, int* e) //입력은 call-by-value. 출력은 pointer 사용. 
{
	//★파일 읽기
	ifstream inFile(fname, ios::binary);

	/*
	파일 읽기를 담당하는 클래스 : ifstream(input file stream)
	파일을 읽기위해 파일 입력(읽기)을 담당하는 클래스인 ifstream클래스로 inFile 객체를 생성하고, 물리적 파일(fname)과 연결함.
	사용하는 파일이 이진파일이므로 ios::binary라는 flag를 넣어 binary로 읽는다는 것을 알려줘야 된다.
	*/

	//===============================================================================================================================================

	//★영상 헤더 읽기 

	/*영상처리할 파일) 메모장으로 헤더부분을 확인한 결과
	P5
	600  677
	255
	=> 픽셀값들을 읽어오기 전에 위의 헤더를 읽어와야된다!
	*/

	string inputLine; //첫번째 문장을 한 번에 읽어오기 위해, string 클래스를 사용해 문자열을 받는 객체 inputLine을 만듦.
	getline(inFile, inputLine); //inFIle로부터 한 줄(\n까지)을 읽어서 inputLine에 저장함.
	cout << inputLine << endl;
	int numCols, numRows;
	inFile >> numCols >> numRows; //inFile에서 600 677값을 읽고, numCols numRows 각각에 넣어줌. (공백으로 입력 구분)
	*c = numRows; //포인터 변수 c와 numRows를 연결시킴. 
	*d = numCols; //포인터 변수 d와 numCols를 연결시킴.
	cout << *d << ' ' << *c << endl;

	int maxValue;
	inFile >> maxValue; //inFile로부터 255를 읽어옴.
	*e = maxValue; //포인터 변수 e와 maxValue를 연결시킴.
	cout << maxValue << endl;

	//===============================================================================================================================================
	
	//★픽셀값들을 읽어서 RAM으로(동적 메모리 할당한 곳으로) 가져오기
	inFile.read(reinterpret_cast<char*>(a), numCols * numRows * sizeof(unsigned char));

	/*
	파일(inFile)에서 file pointer가 가리키고 있는 주소로 가서 numCols * numRows * sizeof(unsigned char)bytes만큼의 데이터를 읽은 다음,
	a가 가리키는 주소로 copy해줌.

	reinterpret_cast<char*>(a)
	=> RAM에서 쓰고있는 pointer와 inFile에서 쓰고있는 file pointer를 호환되게하기위해서, 형변환을 해줌.
	*/

	inFile.close(); //파일을 다 읽은 다음, close()함수를 사용.
	//usage counter를 0으로 바꿔주는 역할을 해, 다른 사람들이 접근할 수 있음을 알려줌.
}

void imageProcessInversion(unsigned char* a, unsigned char* b, int numRows, int numCols)
{
	//★영상처리 : 반전
	for (int row = 0; row < numRows; row++) //0<=row<677의 조건을 만족하면 반복문 실행. 677번 반복.
	{
		for (int col = 0; col < numCols; col++) //0<=col<600의 조건을 만족하면 반복문 실행. 600번 반복.
		{
			b[row * numCols + col] = 255 - a[row * numCols + col];
		}
	}
}

void imageProcessBinarization(unsigned char* a, unsigned char* b, int numRows, int numCols)
{
	//★영상처리 : 이진화
	for (int row = 0; row < numRows; row++) //0<=row<677의 조건을 만족하면 반복문 실행. 677번 반복.
	{
		for (int col = 0; col < numCols; col++) //0<=col<600의 조건을 만족하면 반복문 실행. 600번 반복.
		{
			if (a[row * numCols + col] > 128)
				b[row * numCols + col] = 255;
			else
				b[row * numCols + col] = 0;
		}
	}
}

void writeImage(string fname, unsigned char* b, int numRows, int numCols, int maxValue)
{
	//★영상처리 한 파일을 .pgm파일로 저장하기.
	ofstream outFile;

	/*
	파일을 저장하기 위한 클래스 : ofstream
	파일을 저장하기 위해 ofstream 클래스를 이용해 outFile객체를 만듦.
	*/

	outFile.open(fname, ios::binary);

	//논리적 파일(outFile)과 물리적 파일(fname)을 연결해줌. 이진파일로 저장하므로, ios::binary라는 flag를 적어줌.

	//===============================================================================================================================================

	//★파일 쓰기 오류 확인
	//파일을 저장하는데 오류가 있는지 확인하기 위해!

	if (!outFile) //outFile이라는 객체가 0이 아닌 값을 return해야 정상적인 것! outFile이 0을 return하면 파일을 저장하는 것에 오류가 있음.
	{
		cout << "파일 쓰기 오류." << endl; //파일을 저장할 때 오류가 있으면 실행.
		exit(1); //error를 알려주고, 프로그램 종료.
	}
	cout << "파일을 쓰기 위해 파일 열기 성공." << endl; //파일을 저장할 때 오류가 없으면 실행.

	//===============================================================================================================================================
	
	//★파일 쓰기
	//파일을 쓰는데 문제가 없으면 실행.

	//★파일 쓰기 : 헤더 부분 작성
	//처음에 읽었던 헤더부분과 같게 작성하면 된다!
	outFile << "P5" << endl; //outFile 객체에 'P5' 입력.
	outFile << numCols << ' ' << numRows << endl; 
	outFile << maxValue << endl;

	//★파일 쓰기 : 픽셀 데이터값 작성 
	outFile.write(reinterpret_cast<const char*> (b), numCols * numRows * sizeof(unsigned char));

	/*
	RAM공간의 b 주소부터 시작해서 numCols * numRows * sizeof(unsigned char)bytes 만큼 읽어서 outFile에 쓰기.
	reinterpret_cast<const char*>(b)
	=> RAM에서 쓰고있는 pointer와 outFile에서 쓰고있는 file pointer를 호환되게하기위해서 형변환을 해줌. const는 RAM에 있는 데이터를 그대로 읽어오기위해(read only)
	*/

	outFile.close(); //파일 쓰기를 완료한 경우 close()함수를 이용해 파일을 닫아주기. 
}

int main()
{
	cout << "21812009 조은영" << endl;

	string ifname; //영상처리할 파일명을 입력받기 위해 string class를 사용하여 객체를 만듦.
	cout << "영상처리할 파일명을 입력해주세요 (예 : test.pgm) : ";
	getline(cin, ifname); //사용자로부터 입력을 받은 것의 한 줄(\n까지)을 읽어서 ifname에 저장함.

	//동적 메모리 할당
	unsigned char* a = new unsigned char[600 * 677 * sizeof(unsigned char)]; //readImage함수를 사용해 영상처리할 파일로부터 읽은 픽셀값을 받을 공간을 만듦.
	unsigned char* b = new unsigned char[600 * 677 * sizeof(unsigned char)]; //inversion 또는 binarization을 수행한 결과 픽셀값을 저장할 공간을 만듦.

	int rows, cols, max;
	readImage(ifname, a, b, &rows, &cols, &max); //파일을 읽게 해주는 함수 readImage를 호출
	
	int input;

	cout << "영상처리할 종류를 선택해주세요. (1 : Inversion, 2 : Binarization) : ";
	cin >> input;

	if (input == 1)
	{
		imageProcessInversion(a, b, rows, cols);
	}

	else if (input == 2)
	{
		imageProcessBinarization(a, b, rows, cols);
	}

	else
	{
		cout << "유효하지 않은 영상처리 방법입니다. 프로그램을 다시 실행해주세요." << endl;
		exit(1);
	}

	string ofname; //영상처리한 파일을 저장할 때 저장할 이름을 입력받기 위해 string class를 사용하여 객체를 만듦.
	cout << "저장할 파일명을 입력해주세요 (예  : test.pgm) : ";
	cin.ignore(); //buffer pointer가 \n를 가리키는 것을 cin.ignore()를 사용하여 포인터가 다음 공간을 가리키게 만듦.
	getline(cin, ofname); //사용자로부터 입력을 받은 것의 한 줄(\n까지)을 읽어서 ofname에 저장함.
	writeImage(ofname, b, rows, cols, max); //파일을 쓰게 해주는 함수 writeImage를 호출.

	delete[] a;
	delete[] b; //동적 메모리를 할당해준것은 항상 delete로 지워야된다.

	return 0;
}