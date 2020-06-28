
// MFCView.h: CMFCView 클래스의 인터페이스
//

#pragma once
#include "imageData.h"
#include "majorsimul.h"

class CMFCView : public CFormView
{

private:
	imageData* pImg = NULL; // for image display
	unsigned char* imgCopy1 = NULL;
	unsigned char* imgCopy2 = NULL;
	unsigned char* imgCopy3 = NULL;
	unsigned char* imgCopy4 = NULL;
	unsigned char* imgCopy5 = NULL;
	majorsimul routh;
	int o;
	CString* temp;
	int* temp2;

protected: // serialization에서만 만들어집니다.
	CMFCView() noexcept;
	DECLARE_DYNCREATE(CMFCView)

public:
#ifdef AFX_DESIGN_TIME
	enum{ IDD = IDD_MFC_FORM };
#endif

// 특성입니다.
public:
	CMFCDoc* GetDocument() const;
	int GetFindCharCount(CString parm_string, char parm_find_char);

// 작업입니다.
public:

// 재정의입니다.
public:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.
	virtual void OnInitialUpdate(); // 생성 후 처음 호출되었습니다.
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnPrint(CDC* pDC, CPrintInfo* pInfo);

// 구현입니다.
public:
	virtual ~CMFCView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// 생성된 메시지 맵 함수
protected:
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedImageDisplay();
	afx_msg void OnPaint();
	afx_msg void OnBnClickedInversion();
	afx_msg void OnBnClickedBinarization();
	afx_msg void OnBnClickedBrightnessplus();
	afx_msg void OnBnClickedBrightnessminus();
	afx_msg void OnBnClickedOrder();
	afx_msg void OnBnClickedCoefficient();
	afx_msg void OnBnClickedCriterion();
};

#ifndef _DEBUG  // MFCView.cpp의 디버그 버전
inline CMFCDoc* CMFCView::GetDocument() const
   { return reinterpret_cast<CMFCDoc*>(m_pDocument); }
#endif

