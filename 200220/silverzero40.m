%silverzero34.m 추가

%영역 기반 처리
%영역 기반 처리는 입력 픽셀과 그 주위 픽셀값을 고려하여 출력 픽셀의 값을 결정함
%영역 기반 처리는 영상을 흐리게 또는 선명하게 하거나, 영상의 경계선을 검출하거나, 잡음을 제거하는 연산을 효과적으로 수행할 수
%있음


%영상을 흐리게 하거나, 영상을 선명하게 하거나, 영상의 경계선을 검출하거나, 잡음을 제거하는 영역 기반 처리에서 회선 기법을 적용
%하는 방법은 모두 동일하고 단지 마스크의 값만 서로 다름!


%회선(convolution)
%입력 영상의 각 픽셀에 대한 출력 픽셀 값을 구하기 위해, 입력 픽셀과 그 주위 픽셀의 값에 회선 마스크의 값을 곱한 다음 이들의 합
%을 구함
%현재의 입력 픽셀에 대해 주위 픽셀을 고려할 때, 각 방향으로 대칭되도록 해야 하므로 회선 마스크의 가로와 세로 크기는 홀수여야 함


%사용 될 명령어들

%1. double 클래스에서 uint8 클래스로 변환하는 명령어 (2종류) 
%1) Y=uint8(X) : X의 값을 uint8형으로 변환. 범위 [0,255] 밖에 있는 값은 가장 가까운 끝점에 매핑됨.
%2) J=im2uint8(I) : 회색조, RGB 또는 이진 영상 I를 uint8형으로 변환하고 필요에 따라 데이터를 다시 스케일링하거나 오프셋함
%입력 영상이 logical형 클래스이면 im2uint8은 true 값을 갖는 요소를 255로 변경함



%2. filter2()
%filter를 원 영상 위로 이동하면서 처리

%Y=filter2(filter, image, shape)

%Y : 영역단위 영상처리 결과
%filter : 마스크 영상
%image : 원 영상

%shape : 'same', 'valid', 'full'의 세 종류가 있음. 'same'이 default.
%same : default. 출력 영상은 원영상과 동일한 크기의 매트릭스. 에지 처리는 pad with zeros
%valid : 마스크를 영상 내부의 완전히 중첩되는 화소에만 처리. 에지 처리는 ignore edges. 
%        'same'으로 처리한 결과는 원영상의 외부에 미리 0으로 채운 후 'valid'로 처리하면 얻을 수 잇음
%full : 출력은 원영상보다 더 큰 크기. 영상의 화소값이 없는 경우 '0'으로 채움. 
%       마스크와 영상 행렬이 서로 겹치는 부분이 있으면 영상과 주위의 모든 곳에서 필터를 적용하여 출력 매트릭스를 생성(?)

%filter2() 의 결과는 double data type





%영상 흐리게 하기
%여기서 사용되는 회선 마스크는 각 입력 픽셀값을 주위 픽셀값들과의 '평균값으로 변환'함

%3*3 크기의 회선 마스크를 사용하여 영상 흐리게 하기
f=imread('lena.jpg');
mask33=[1/9, 1/9, 1/9; 1/9, 1/9, 1/9; 1/9, 1/9, 1/9];
result33=filter2(mask33, f);
result33=uint8(result33); %★result33=im2uint8(result33);을 쓰면 모든 값이 255가 됨. 왜 그런지 생각해보기!
imshow(f), figure, imshow(result33);

%5*5 크기의 회선 마스크를 사용하여 영상 흐리게 하기
mask55=ones(5);
mask55=1/25*mask55;
result55=filter2(mask55, f);
reulst55=uint8(result55);
imshow(f), figure, imswho(result55);

%11*11 크기의 회선 마스크를 사용하여 영상 흐리게 하기
mask1111=ones(11);
mask1111=1/121*mask1111;
result1111=filter2(mask1111, f);
result1111=uint8(result1111);
imshow(f), figure, imshow(result1111);

%마스크의 크기가 커질수록 흐려지는 정도가 더 커지는 것을 확인할 수 있었습니다

%+추가
%3*3 크기의 회선 마스크를 사용하여 영상 흐리게 하기(valid)
result33_valid=filter2(mask33, f, 'valid');
result33_valid=uint8(result33_valid);
imshow(result33_valid2);


%3*3 크기의 회선 마스크를 사용하여 영상 흐리게 하기(full)
result33_full=filter2(mask33, f, 'full');
result33_full=uint8(result33_full);
imshow(result33_full);




%영상 선명하게 하기
%영상을 선명하게 해주는 마스크 (2종류)
%1) [0 -1 0; -1 5 -1; 0 -1 0]
%2) [-1 -1 -1; -1 9 -1; -1 -1 -1]
%위의 마스크들을 적용하면 결과값이 0보다 작거나 255보다 커질 수 있으므로, 그런 경우에는 0과 255의 값을 갖도록 수정해야 함

%영상을 흐리게 해주는 회선 마스크와 영상을 선명하게 해주는 마스크들(위의 2개)은 마스크 내의 값들을 모두 합하면 1이 된다는 것을
%확인할 수 있음!
%마스크 내의 값을 합하면 1이 되도록 함으로써 회선 마스크를 적용하기 전과 적용한 후의 영상에서 전체적인 영상의 밝기가 비슷하게
%조절된다는 특성이 있음

%마스크 1 적용
mask1=[0 -1 0; -1 5 -1; 0 -1 0];
result_mask1=filter2(mask1, f);
result_mask1=uint8(result_mask1);
imshow(f), figure, imshow(result_mask1);

%마스크 2 적용
mask2=[-1 -1 -1; -1 9 -1; -1 -1 -1];
result_mask2=filter2(mask2, f);
result_mask2=uint8(result_mask2);
imshow(f), figure, imshow(result_mask1), figure, imshow(result_mask2);

%마스크 1 두 번 적용
result_mask1=filter2(mask1, f);
result_mask1=uint8(result_mask1);
result_mask11=filter2(mask1, result_mask1);
result_mask11=uint8(result_mask11);
imshow(result_mask11);

%마스크 2 두 번 적용
result_mask2=filter2(mask2, f);
result_mask2=uint8(result_mask2);
result_mask22=filter2(mask2, result_mask2);
result_mask22=uint8(result_mask22);
imshow(result_mask22);





%경계선 검출
%상대적으로 다른 명암도를 가진 두 영역 간의 경계를 검출함
%미분 개념을 이용해 경계선을 검출하는 방법이 널리 사용되고 있음

%미분을 이용한 경계선 검출용 회선 마스크 (3종류)
%두 개의 회선 마스크를 이용하여 회선을 수행함. 한 회선 마스크는 수평 방향의 경계선을 구하고, 다른 회선 마스크는 수직 방향의
%경계썬을 구하기 위해 사용됨
%1) Prewitt 마스크
%수평 경계선 : [-1 -1 -1; 0 0 0; 1 1 1]
%수직 경계썬 : [1 0 -1; 1 0 -1; 1 0 -1]
%2) Roberts 마스크
%수평 경계선 : [-1 0; 0 1]
%수직 경계선 : [0 -1; 1 0]
%3) Sobel 마스크
%수평 경계선 : [-1 -2 -1; 0 0 0; 1 2 1]
%수직 경계선 : [1 0 -1; 2 0 -2; 1 0 -1]

%Prewitt 마스크는 대각 방향의 경계선보다는 수평, 수직 경계선에 더 민감함
%Roberts 마스크는 다른 마스크보다 크기가 작아서 연산이 효율적이지만 잡음에 민감함
%Sobel 마스크는 수평, 수직 방향의 경계선보다는 대각선 방향의 경계선에 더 민감함

%Prewitt 마스크의 경우에는 마스크 중심에서의 거리와 관계없이 +1또는 -1의 값을 가지고 있음
%반면에 Sobel 마스크에서는 마스크의 중심에 가까운 픽셀은 +2 또는 -2의 값을 가지고, 먼 픽셀은 +1 또는 -1의 값을 가지도록
%되어 있어 보다 정확한 경계선을 검출할 수 있음

%Prewitt 마스크를 이용해 경계선 검출
mask_prewitt_h=[-1 -1 -1; 0 0 0; 1 1 1]; %수평 경계선을 검출하는 Prewitt 마스크
mask_prewitt_v=[1 0 -1; 1 0 -1; 1 0 -1]; %수직 경계선을 검출하는 Prewitt 마스크

result_prewitt_h=filter2(mask_prewitt_h, f);
result_prewitt_h=uint8(result_prewitt_h);

result_prewitt_v=filter2(mask_prewitt_v, f);
result_prewitt_v=uint8(result_prewitt_v);

result_prewitt=result_prewitt_h + result_prewitt_v;

imshow(result_prewitt_h), figure, imshow(result_prewitt_v), figure, imshow(result_prewitt);


%Roberts 마스크를 이용해 경계선 검출
mask_roberts_h=[-1 0; 0 1]; %수평 경계선을 검출하는 Roberts 마스크
mask_roberts_v=[0 -1; 1 0]; %수직 경계선을 검출하는 Roberts 마스크

result_roberts_h=filter2(mask_roberts_h, f);
result_roberts_h=uint8(result_roberts_h);

result_roberts_v=filter2(mask_roberts_v, f);
result_roberts_v=uint8(result_roberts_v);

result_roberts=result_roberts_h + result_roberts_v;

imshow(result_roberts_h), figure, imshow(result_roberts_v), figure, imshow(result_roberts);


%Sobel 마스크를 이용해 경계선 검출
mask_sobel_h=[-1 -2 -1; 0 0 0; 1 2 1]; %수평 경계선을 검출하는 Sobel 마스크
mask_sobel_v=[1 0 -1; 2 0 -2; 1 0 -1]; %수직 경계선을 검출하는 Sobel 마스크

result_sobel_h=filter2(mask_sobel_h, f);
result_sobel_h=uint8(result_sobel_h);

result_sobel_v=filter2(mask_sobel_v, f);
result_sobel_v=uint8(result_sobel_v);

result_sobel=result_sobel_h + result_sobel_v;

imshow(result_sobel_h), figure, imshow(result_sobel_v), figure, imshow(result_sobel);