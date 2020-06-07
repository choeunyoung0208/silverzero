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
%1) Y=uint8(X) : X의 값을 uint8형으로 변환. 범위 [0,28-1] 밖에 있는 값은 가장 가까운 끝점에 매핑됨.
%2) J=im2uint8(I) : 회색조, RGB 또는 이진 영상 I를 uint8형으로 변환하고 필요에 따라 데이터를 다시 스케일링하거나 오프셋함
%입력 영상이 logical형 클래스이면 im2uint8은 true 값을 갖는 요소를 255로 변경함

%2. filter2()
%filter를 원 영상 위로 이동하면서 처리
%Y=filter2(filter, image, shape)
%Y : 영역단위 영상처리 결과
%filter : 마스크 영상
%image : 원 영상
%shape : 'same', 'valid', 'full'의 세 종류가 있음. 'same'이 default.
%filter2() 의 결과는 double data type






%영상 흐리게 하기
%여기서 사용되는 회선 마스크는 각 입력 픽셀값을 주위 픽셀값들과의 평균값으로 변환함

%3*3 크기의 회선 마스크를 사용하여 영상 흐리게 하기
f=imread('lena.jpg');
mask33=[1/9, 1/9, 1/9; 1/9, 1/9, 1/9; 1/9, 1/9, 1/9];
result33=filter2(mask33, f);
result33=uint8(result33);
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