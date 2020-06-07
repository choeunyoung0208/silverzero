#include <iostream> //키보드, 모니터의 입출력을 담당하는 iostream 클래스를 불러옴.
#include <string> //문자열 데이터를 사용하기 위해 string 클래스(또는 라이브러리 라고함)를 불러옴.
#include <fstream> //파일 입출력(읽기, 쓰기)을 담당하는 fstream 클래스를 불러옴.

using namespace std;

int main()
{
	//★Read data from an image file
	ifstream inFile("C:\\Users\\5111s\\Desktop\\으녕.pgm", ios::binary);
	/*파일 읽기를 담당하는 클래스 : ifstream(input file stream)
	파일을 읽기위해 파일 입력(읽기)을 담당하는 클래스인 ifstream클래스로 inFile 객체를 생성하고, 물리적 파일(으녕.pgm)과 연결함.
	사용하는 파일이 이진파일이므로 ios::binary라는 flag를 넣어 binary로 읽는다는 것을 알려줘야 된다.*/

	//===============================================================================================================================================

	/*메모장으로 파일의 헤더부분을 확인한 결과
	P5
	1315  1498
	255
	픽셀값들을 읽어오기 전에 위의 헤더를 읽어와야된다!*/

	//★헤더 읽어오는 부분
	//Read 1st line (P5)
	string inputLine; //한 문장씩 읽어오기 위해, string 클래스를 사용해 문자열을 받는 객체 inputLine을 만듦.
	getline(inFile, inputLine); //inFIle로부터 한 줄(\n까지)을 읽어서 inputLine에 저장함.
	cout << inputLine << endl; //inputLine에 저장된 문장을 화면에 출력. (잘 읽어왔는지 확인해보기 위해!)

	//Read 2nd line (1315, 1498)
	//영상의 크기를 알려주는 부분. 1315는 폭(가로 길이), 1498은 높이(세로 길이)를 나타냄.
	int numCols, numRows;  
	inFile >> numCols >> numRows;
	/*영상의 폭: 행렬의 열 개수에 해당. 
	영상의 높이: 행렬의 행 개수에 해당.
	따라서, inFile로 부터 첫번째로 읽어온 값을 numCols에 넣어주고, 두번째로 읽어온 값을 numRows에 넣어줌. 
	공백 전까지를 하나의 값으로 읽어옴!(공백으로 다음 글자를 구분함.)
	int가 4bytes이므로, 4bytes(RAM memory에서 4칸에 해당)를 읽어서 숫자(정수형)로 바꾼 다음에 numCols와 numRows에 넣어줌.
	이 역할은 '>>' extraction operator가 함.*/
	cout << numCols << ' ' << numRows << endl; //numCols, numRows에 저장된 값을 화면에 출력. (잘 읽어왔는지 확인해보기 위해!)

	//Read 3rd line (max value)
	//max value는 bit data가 픽셀당 8bits인지 16bits인지 알려주는 중요한 지표.
	int maxValue;
	inFile >> maxValue; //inFile로부터 값을 읽어옴. (공백 전까지)
	//마찬가지로, 읽어낸 다음에 숫자(정수형)로 바꿔서 maxValue에 넣어줌.
	cout << maxValue << endl; //maxValue에 저장된 값을 화면에 출력. (잘 읽어왔는지 확인해보기 위해!)

	cout << "헤더 부분 읽기 완료." << endl;

	//===============================================================================================================================================

	//★영상 데이터를 읽어서 RAM공간에 저장하기 위해 동적 메모리 할당(RAM 공간의 HEAP 영역에 필요한 용량 만큼 할당)
	//RAM 영역에다가 저장해야 될 공간을 미리 확보해놓아야 되므로!

	unsigned char* data1D = new unsigned char[numCols * numRows * sizeof(unsigned char)]; //동적 메모리 할당 명령어. 
	/*
	unsigned char* data1D 
	=> new함수가 data1D라는 변수에 동적 메모리를 할당한 부분의 시작 주소를 알려준다. 그래서 data1D는 포인터로 선언.
	data1D가 가리키는 RAM의 주소로 가서 1byte씩 저장할 것이므로, unsigned char로 선언.

	new unsigned char[numCols * numRows * sizeof(unsigned char)];
	=> new + datatype[RAM공간에 할당해야 될 크기(byte단위)]
	따라서, numCols * numRows * sizeof(unsigned char)bytes만큼의 공간을 확보함.*/

	//===============================================================================================================================================

	//★픽셀값들을 읽어서 RAM으로 가져오기(Read raw data)
	inFile.read(reinterpret_cast<char*>(data1D), numCols * numRows * sizeof(unsigned char));
	/*파일(inFile)에서 file pointer가 가리키고 있는 주소로 가서 numCols * numRows * sizeof(unsigned char)bytes만큼의 데이터를 읽은 다음, 
	data1D가 가리키는 주소로 copy해줌.
	reinterpret_cast<char*>(data1D)
	=> RAM에서 쓰고있는 pointer와 inFile에서 쓰고있는 file pointer를 호환되게하기위해서, 형변환을 해줌.*/

	//파일 읽기 끝
	inFile.close(); //파일을 다 읽은 다음, close()함수를 사용.
	//usage counter를 0으로 바꿔주는 역할을 해, 다른 사람들이 접근할 수 있음을 알려줌.

	//RAM으로 영상 데이터 읽어오기 끝

	//===============================================================================================================================================

	//★영상처리 : 반전
	//실제 영상은 2차원 이므로, 2차원 배열 형태로 읽어냄. 
	for (int row = 0; row < numRows; row++) //0<=row<1498의 조건을 만족하면 반복문 실행. 1498번 반복.
	{
		for (int col = 0; col < numCols; col++) //0<=col<1315의 조건을 만족하면 반복문 실행. 1315번 반복.
		{
			data1D[row * numCols + col] = 255 - data1D[row * numCols + col]; 
			//각 픽셀마다 data1D[row*numCols+col]값을 읽어 255-data1D[row*numCols+col]연산을 한 결과를 data1D[row*numCols+col]에 다시 할당.
		}
	}
	cout << "영상 반전 완료." << endl;

	//===============================================================================================================================================

	//★영상처리 한 파일을 .pgm파일로 저장하기.
	//파일을 저장하기 위한 클래스 : ofstream
	ofstream outFile; //파일을 저장하기 위해 ofstream 클래스를 이용해 outFile객체를 만듦.
	outFile.open("inversion.pgm", ios::binary); //논리적 파일(outFile)과 물리적 파일(inversion.pgm)을 연결해줌. 
	//이진파일로 저장하므로, ios::binary라는 flag를 적어줌.

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
	outFile << numCols << " " << numRows << endl;
	outFile << maxValue << endl;
	cout << "헤더 부분 작성 완료." << endl;

	//★파일 쓰기 : 픽셀 데이터값 작성 
	outFile.write(reinterpret_cast<const char*>(data1D), numCols * numRows * sizeof(unsigned char));
	/*RAM공간의 data1D 주소부터 시작해서 numCols * numRows * sizeof(unsigned char)bytes 만큼 읽어서 outFile에 쓰기.
	reinterpret_cast<char*>(data1D)
	=> RAM에서 쓰고있는 pointer와 outFile에서 쓰고있는 file pointer를 호환되게하기위해서, 형변환을 해줌. */

	outFile.close(); //파일 쓰기를 완료한 경우 close()함수를 이용해 파일을 닫아주기. 

	delete(data1D); //동적 메모리를 할당해준것은 항상 delete로 지워야된다.

	cout << "영상처리 완료." << endl;

	return 0;
}

