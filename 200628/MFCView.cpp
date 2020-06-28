
// MFCView.cpp: CMFCView 클래스의 구현
//

#include "pch.h"
#include "framework.h"
// SHARED_HANDLERS는 미리 보기, 축소판 그림 및 검색 필터 처리기를 구현하는 ATL 프로젝트에서 정의할 수 있으며
// 해당 프로젝트와 문서 코드를 공유하도록 해 줍니다.
#ifndef SHARED_HANDLERS
#include "MFC.h"
#endif

#include "MFCDoc.h"
#include "MFCView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

#include <CString>
#include <string>




// CMFCView

IMPLEMENT_DYNCREATE(CMFCView, CFormView)

BEGIN_MESSAGE_MAP(CMFCView, CFormView)
	// 표준 인쇄 명령입니다.
	ON_COMMAND(ID_FILE_PRINT, &CFormView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, &CFormView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CFormView::OnFilePrintPreview)
	ON_BN_CLICKED(IDC_BUTTON1, &CMFCView::OnBnClickedImageDisplay)
	ON_WM_PAINT()
	ON_BN_CLICKED(IDC_BUTTON2, &CMFCView::OnBnClickedInversion)
	ON_BN_CLICKED(IDC_BUTTON3, &CMFCView::OnBnClickedBinarization)
	ON_BN_CLICKED(IDC_BUTTON4, &CMFCView::OnBnClickedBrightnessplus)
	ON_BN_CLICKED(IDC_BUTTON8, &CMFCView::OnBnClickedBrightnessminus)
	ON_BN_CLICKED(IDC_BUTTON5, &CMFCView::OnBnClickedOrder)
	ON_BN_CLICKED(IDC_BUTTON6, &CMFCView::OnBnClickedCoefficient)
	ON_BN_CLICKED(IDC_BUTTON7, &CMFCView::OnBnClickedCriterion)
END_MESSAGE_MAP()

// CMFCView 생성/소멸

CMFCView::CMFCView() noexcept
	: CFormView(IDD_MFC_FORM)
{
	// TODO: 여기에 생성 코드를 추가합니다.

}

CMFCView::~CMFCView()
{
	if (imgCopy1) // delete new object
		delete[] imgCopy1;
	else if (imgCopy2) // delete new object
		delete[] imgCopy2;
	else if (imgCopy3) // delete new object
		delete[] imgCopy3;
	else if (imgCopy4) // delete new object
		delete[] imgCopy4;
	else if (imgCopy5) // delete new object
		delete[] imgCopy5;

	delete[] temp;
	delete[] temp2;
}

void CMFCView::DoDataExchange(CDataExchange* pDX)
{
	CFormView::DoDataExchange(pDX);
}

BOOL CMFCView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: CREATESTRUCT cs를 수정하여 여기에서
	//  Window 클래스 또는 스타일을 수정합니다.

	return CFormView::PreCreateWindow(cs);
}

void CMFCView::OnInitialUpdate()
{
	CFormView::OnInitialUpdate();
	GetParentFrame()->RecalcLayout();
	ResizeParentToFit();

}


// CMFCView 인쇄

BOOL CMFCView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// 기본적인 준비
	return DoPreparePrinting(pInfo);
}

void CMFCView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 인쇄하기 전에 추가 초기화 작업을 추가합니다.
}

void CMFCView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 인쇄 후 정리 작업을 추가합니다.
}

void CMFCView::OnPrint(CDC* pDC, CPrintInfo* /*pInfo*/)
{
	// TODO: 여기에 사용자 지정 인쇄 코드를 추가합니다.
}


// CMFCView 진단

#ifdef _DEBUG
void CMFCView::AssertValid() const
{
	CFormView::AssertValid();
}

void CMFCView::Dump(CDumpContext& dc) const
{
	CFormView::Dump(dc);
}

CMFCDoc* CMFCView::GetDocument() const // 디버그되지 않은 버전은 인라인으로 지정됩니다.
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CMFCDoc)));
	return (CMFCDoc*)m_pDocument;
}
#endif //_DEBUG


// CMFCView 메시지 처리기

void CMFCView::OnPaint()
{
	CPaintDC dc(this); // device context for painting
					   // TODO: 여기에 메시지 처리기 코드를 추가합니다.
					   // 그리기 메시지에 대해서는 CFormView::OnPaint()을(를) 호출하지 마십시오.
	if (imgCopy1) // if image data exists, display the image
	{
		// display image using SetPixel
		unsigned char value1;
		for (int i = 0; i < pImg->getHeight(); i++)
			for (int j = 0; j < pImg->getWidth(); j++)
			{
				int ypos = 250 + i;
				int xpos = 10 + j;
				value1 = imgCopy1[i * pImg->getWidth() + j]; // get image pixel value
				dc.SetPixel(xpos, ypos, RGB(value1, value1, value1));
			}
	}

	/*else if (imgCopy2)
	{
		unsigned char value2;
		for (int i = 0; i < pImg->getHeight(); i++)
			for (int j = 0; j < pImg->getWidth(); j++)
			{
				int ypos = 250 + i;
				int xpos = 10 + j;
				value2 = imgCopy2[i * pImg->getWidth() + j]; // get image pixel value
				dc.SetPixel(xpos, ypos, RGB(value2, value2, value2));
			}
	}

	else if (imgCopy3)
	{
		unsigned char value3;
		for (int i = 0; i < pImg->getHeight(); i++)
			for (int j = 0; j < pImg->getWidth(); j++)
			{
				int ypos = 250 + i;
				int xpos = 10 + j;
				value3 = imgCopy3[i * pImg->getWidth() + j]; // get image pixel value
				dc.SetPixel(xpos, ypos, RGB(value3, value3, value3));
			}
	}

	else if (imgCopy4)
	{
		unsigned char value4;
		for (int i = 0; i < pImg->getHeight(); i++)
			for (int j = 0; j < pImg->getWidth(); j++)
			{
				int ypos = 250 + i;
				int xpos = 10 + j;
				value4 = imgCopy4[i * pImg->getWidth() + j]; // get image pixel value
				dc.SetPixel(xpos, ypos, RGB(value4, value4, value4));
			}
	}

	else if (imgCopy5)
	{
		unsigned char value5;
		for (int i = 0; i < pImg->getHeight(); i++)
			for (int j = 0; j < pImg->getWidth(); j++)
			{
				int ypos = 250 + i;
				int xpos = 10 + j;
				value5 = imgCopy5[i * pImg->getWidth() + j]; // get image pixel value
				dc.SetPixel(xpos, ypos, RGB(value5, value5, value5));
			}
	}*/
}


void CMFCView::OnBnClickedImageDisplay()
{
	// TODO: 여기에 컨트롤 알림 처리기 코드를 추가합니다.
	AfxMessageBox(_T("ImageDisplay"));
	CMFCDoc* pDoc = GetDocument();
	pImg = pDoc->getImg();
	imgCopy1 = new unsigned char[pImg->getHeight() * pImg->getWidth()];
	pImg->getImage(imgCopy1); // get image data to display
	Invalidate(true); // active WM_PAINT message
}

void CMFCView::OnBnClickedInversion()
{
	// TODO: 여기에 컨트롤 알림 처리기 코드를 추가합니다.
	AfxMessageBox(_T("Inversion"));
	CMFCDoc* pDoc = GetDocument();
	pImg = pDoc->getImg();
	imgCopy2 = new unsigned char[pImg->getHeight() * pImg->getWidth()];
	pImg->imageProc(0);
	pImg->getImage(imgCopy2); // get image data to display
	Invalidate(true); // active WM_PAINT message
}


void CMFCView::OnBnClickedBinarization()
{
	// TODO: 여기에 컨트롤 알림 처리기 코드를 추가합니다.
	AfxMessageBox(_T("Binarization"));
	CMFCDoc* pDoc = GetDocument();
	pImg = pDoc->getImg();
	imgCopy3 = new unsigned char[pImg->getHeight() * pImg->getWidth()];
	pImg->imageProc(1);
	pImg->getImage(imgCopy3); // get image data to display
	Invalidate(true); // active WM_PAINT message
}


void CMFCView::OnBnClickedBrightnessplus()
{
	// TODO: 여기에 컨트롤 알림 처리기 코드를 추가합니다.
	AfxMessageBox(_T("Brightness +10"));
	CMFCDoc* pDoc = GetDocument();
	pImg = pDoc->getImg();
	imgCopy4 = new unsigned char[pImg->getHeight() * pImg->getWidth()];
	pImg->imageProc(2);
	pImg->getImage(imgCopy4); // get image data to display
	Invalidate(true); // active WM_PAINT message
}


void CMFCView::OnBnClickedBrightnessminus()
{
	// TODO: 여기에 컨트롤 알림 처리기 코드를 추가합니다.
	AfxMessageBox(_T("Brightness -10"));
	CMFCDoc* pDoc = GetDocument();
	pImg = pDoc->getImg();
	imgCopy5 = new unsigned char[pImg->getHeight() * pImg->getWidth()];
	pImg->imageProc(3);
	pImg->getImage(imgCopy5); // get image data to display
	Invalidate(true); // active WM_PAINT message
}


void CMFCView::OnBnClickedOrder()
{
	// TODO: 여기에 컨트롤 알림 처리기 코드를 추가합니다.
	UpdateData(TRUE); // 에디트 박스 값을 불러오기
	CString strName; // 에디트 값이 저장될 변수선언
	GetDlgItemText(IDC_EDIT1, strName);
	o = _ttoi(strName);
	routh.setmajorsimul(o);
	CString output;
	output.Format(L"특성방정식의 차수 : %d", o);
	AfxMessageBox(output);
}


void CMFCView::OnBnClickedCoefficient()
{
	// TODO: 여기에 컨트롤 알림 처리기 코드를 추가합니다.
	UpdateData(TRUE); // 에디트 박스 값을 불러오기
	CString strName2; // 에디트 값이 저장될 변수선언
	GetDlgItemText(IDC_EDIT2, strName2);
	
	CString strTok;
	int sepCount = GetFindCharCount(strName2, ',');
	//CString* temp = new CString[sepCount + 1];
	//int* temp2 = new int[sepCount + 1];
	temp = new CString[sepCount + 1];
	temp2 = new int[sepCount + 1];

	int cnt = 0;
	int i = 0;
	while (AfxExtractSubString(strTok, strName2, cnt, ','))
	{
		temp[cnt++] = strTok;
		temp2[i] = _ttoi(temp[i]);
		CString output2;
		output2.Format(L"%d차항 계수 : %d", o - i, temp2[i]);
		AfxMessageBox(output2);
		i = i + 1;
	}

	int col1 = (o + 1) / 2;
	int col2 = (o + 1) % 2;
	int col = col1 + col2;
	int p = 0;

	for (int i=0;i<col;i++)
		for (int j = 0; j < 2; j++)
		{
			routh.setfirstarray(temp2[p], j, i);
			p++;
		}
	
	if (col != col1)
	{
		routh.setfirstarray(0, 1, col - 1);
	}
}

int CMFCView::GetFindCharCount(CString parm_string, char parm_find_char)
{
	int length = parm_string.GetLength();
	int find_count = 0;
	for (int i = 0; i < length; i++)
	{
		if (parm_string[i] == parm_find_char)
		{
			find_count++;
		}
	}
	return find_count;
}


void CMFCView::OnBnClickedCriterion()
{
	// TODO: 여기에 컨트롤 알림 처리기 코드를 추가합니다.
	routh.routharray();

	int roots;
	roots = routh.criterion();

	if (roots == 0)
	{
		AfxMessageBox(_T("우반면에 위치한 근의 개수 : 0개. \n시스템 안정/불안정 여부 : 안정."));
	}
	else if (roots > 0)
	{
		CString output3;
		output3.Format(L"우반면에 위치한 근의 개수 : %d개. \n시스템 안정/불안정 여부 : 불안정.", roots);
		AfxMessageBox(output3);
	}
}