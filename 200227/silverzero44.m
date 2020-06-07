%영역 기반 처리 - 잡음(noise) 제거

%잡음은 임펄스(impulse) 잡음과 가우시안(Gaussian) 잡음으로 구분할 수 있음.
%임펄스 잡음 : 0또는 255와 같이 영상의 픽셀값과는 뚜렷하게 다른 픽셀값에 의한 잡음을 말함.
%가우시안 잡음 : 영상의 픽셀값으로부터 불규칙적으로 벗어나지만 뚜렷하게 벗어나지는 않은 픽셀값에 의한 잡음을 말함. (책에 이렇게
%적혀있는데 무슨 소리인지 이해가 안 가서 다시 찾아보았습니다..ㅎㅎ)
%정규분포를 가지는 잡음. 쉽게 말해 일반적인 잡음(임펄스 잡음처럼 갑자기 튀는 잡음이 아님, 계속 같은 레벨의 잡음도 아님)이며 어느 정도 랜덤하면서
%자연계에서 쉽게 볼 수 있는 분포를 말함.





%사용되는 함수
%1) imnoise : 영상에 잡음 추가

%imnoise(I,'gaussian')
%ex) imnoise(I,'gaussian') : 분산 0.01과 평균 0의 가우스 백색 잡음을 회색조 영상 I에 추가.

%imnoise(I,'salt & pepper',d) : 점잡음을 추가함. 여기서 d는 잡음 밀도(default : 0.05). 
%ex) imnoise(I,'salt & pepper',0.02) : 잡음 밀도가 0.02인 점잡음(Salt and Pepper
%Noise)을 영상에 추가.


%2) randi : 정수형 난수 생성
%ex) randi([10 50],1,5) : 10에서 50 사이에 균일하게 분포된 5개의 정수형 난수를 생성





%잡음을 제거하는 방법
%1) 평균 마스크를 이용한 회선 기법
%가우시안 잡음은 흐린 영상 생성을 위한 평균 마스크를 이용한 회선 기법을 사용하여 효과적으로 제거할 수 있음.
%가우시안 잡음은 원래의 픽셀값에서 크게 벗어나지 않기 때문에 주위의 잡음이 아닌 픽셀값들과 평균을 구하면 영상이 흐려지면서 잡음이
%보이지 않음.

f=imread('lena.jpg');
gaussian=imnoise(f, 'gaussian'); %영상 f에 gaussian noise를 추가
impulse=imnoise(f, 'salt & pepper'); %영상 f에 impulse noise를 추가

%3*3 크기의 평균 마스크
average33=fspecial('average');
average33_gaussian=filter2(average33, gaussian);
average33_gaussian=uint8(average33_gaussian);

average33_impulse=filter2(average33, impulse);
average33_impulse=uint8(average33_impulse);


%5*5 크기의 평균 마스크
average55=fspecial('average', 5);
average55_gaussian=filter2(average55, gaussian);
average55_gaussian=uint8(average55_gaussian);
imshow(average33_gaussian), figure, imshow(average55_gaussian);

average55_impulse=filter2(average55, impulse);
average55_impulse=uint8(average55_impulse);
imshow(average33_impulse), figure, imshow(average55_impulse);





%2) 중간값 필터를 이용
%임펄스 잡음을 효과적으로 제거할 수 잇는 방법.
%입력 픽셀과 주위 픽셀들의 값 중에서 중간값을 찾아서 이를 출력 픽셀값으로 사용하는 방법.
%중간값 필터는 경계선을 잘 보존함. (평균 마스크를 이용하면 영상이 흐려져 경계선이 모호해지는 반면, 중간값 필터는 영상을 흐리게
%하지 않음.)

%임펄스 잡음은 평균 마스크를 이용한 회선 기법 보다는 중간값 필터를 이용하는 것이 잡음을 훨씬 더 잘 제거함을 볼 수 있음.

%3*3 크기의 중간값 필터
k1=ordfilt2(gaussian, 5, ones(3, 3));
k2=ordfilt2(impulse, 5, ones(3, 3));

%5*5 크기의 중간값 필터
k3=ordfilt2(gaussian, 13, ones(5, 5));
k4=ordfilt2(impulse, 13, ones(5, 5));
imshow(k1), figure, imshow(k3), figure, imshow(k2), figure, imshow(k4);