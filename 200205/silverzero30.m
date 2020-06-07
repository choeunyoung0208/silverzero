f=imread('image1.jpg');
f1=rgb2gray(f); %입력받은 영상 f를 grayscale로 변환
f2=(f1>150); %grayscale로 변환된 영상 f1을 이진화. 150보다 큰 값은 255로, 나머지는 0으로 변환.

%침식연산
%imerode(image, kernel) 명령어를 사용하여 침식연산 수행
%image : 침식연산을 수행할 영상
%kernel : 필터 윈도우. 필터 윈도우 각 요소는 0또는 1의 값을 가질 수 있다. 행렬의 크기가 클수록 연산의 효과가 더 커짐. 
k=ones(3, 3); %모든 요소가 1인 3*3의 필터 윈도우 생성
k1=ones(5, 5);
k2=ones(7, 7);
erode1=imerode(f2, k); %kernel k를 이용하여 이미지 f2를 침식연산
erode2=imerode(f2, k1); %kernel k1을 이용하여 이미지 f2를 침식연산
erode3=imerode(f2, k2); %kernel k2를 이용하여 이미지 f2를 침식연산
imshow(f2), figure, imshow(erode1), figure, imshow(erode2), figure, imshow(erode3); 
%f2, erode1, erode2, erode3 영상을 모두 출력하여 결과 비교



%팽창연산
%imdilate(image, kernel) 명령어를 사용하여 팽창연산 수행
%위의 침식연산과 사용법은 똑같음.
%위에서 생성한 필터 윈도우를 똑같이 사용.
dilate1=imdilate(f2, k);  %kernel k를 이용하여 이미지 f2를 팽창연산
dilate2=imdilate(f2, k1); %kernel k1을 이용하여 이미지 f2를 팽창연산
dilate3=imdilate(f2, k2); %kernel k2를 이용하여 이미지 f2를 팽창연산
imshow(f2), figure, imshow(dilate1), figure, imshow(dilate2), figure, imshow(dilate3);
%f2, dilate1, dilate2, dilate3 영상을 모두 출력하여 결과 비교


%열림연산
%열림연산은 침식연산을 적용한 다음에 팽창연산을 적용하는 연산.
%imopen(image, kernel) 명령어를 사용하여 열림연산 수행
open1=imopen(f2, k);
open2=imopen(f2, k1);
open3=imopen(f2, k2);
imshow(f2), figure, imshow(open1), figure, imshow(open2), figure, imshow(open3);

%열림연산의 정의가 침식연산을 적용한 다음에 팽창연산을 적용하는 연산이므로,
%침식연산, 팽창연산 명령어를 사용해서도 열림연산을 실행해보았습니다.
open4=imdilate(erode1, k);
open5=imdilate(erode2, k1);
open6=imdilate(erode3, k2);
imshow(open1), figure, imshow(open2), figure, imshow(open3), figure, imshow(open4), figure, imshow(open5), figure, imshow(open6);
%비교해 본 결과 같은 영상이 출력됨을 확인할 수 있었습니다.



%닫힘연산
%닫힘연산은 팽창연산을 적용한 다음에 침식연산을 적용하는 연산.
%imclose(image, kernel) 명령어를 사용하여 닫힘연산 수행
close1=imclose(f2, k);
close2=imclose(f2, k1);
close3=imclose(f2, k2);
imshow(f2), figure, imshow(close1), figure, imshow(close2), figure, imshow(close3);

%닫힘연산의 정의가 팽창연산을 적용한 다음에 침식연산을 적용하는 연산이므로,
%팽창연산, 침식연산 명령어를 사용해서도 닫힘연산을 실행해보았습니다.
close4=imerode(dilate1, k);
close5=imerode(dilate2, k1);
close6=imerode(dilate3, k2);
imshow(close1), figure, imshow(close2), figure, imshow(close3), figure, imshow(close4), figure, imshow(close5), figure, imshow(close6);
%비교해 본 결과 같은 영상이 출력됨을 확인할 수 있었습니다.



%+ 추가로 해 본 것들..!
%모든 요소가 1인 12*12의 크기를 가지는 kernel을 생성해서 침식연산 수행
k3=ones(12, 12);
erode4=imerode(f2, k3);
imshow(erode3), figure, imshow(erode4);

%f, f1, f2 영상에 대해 k3 kernel을 이용한 침식연산 수행
%f : rgb값을 가지는 영상, 
%f1 : grayscale의 값을 가지는 영상, 
%f2 : 이진화된 영상
erodee1=imerode(f, k3);
erodee2=imerode(f1, k3);
erodee3=imerode(f2, k3);
imshow(erodee1), figure, imshow(erodee2), figure, imshow(erodee3);