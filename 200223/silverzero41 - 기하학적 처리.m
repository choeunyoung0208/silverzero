%기하학적 처리
%영상의 확대, 축소, 회전, 대칭


%영상을 확대하는 방법
%픽셀 복제 방법, 역방향 사상과 양선형 보간법이 있음.
%두 방법 다 imresize 명령어를 사용해 영상 확대가능

%imre=imresize(image, scale or [m, n], 'method');
%imresize : 영상의 크기를 스케일링해주는 함수
%imresize명령어 사용 결과 출력되는 영상
%image : 원본 영상
%scale : 배수
%[m, n] : 스케일링될 출력 크기
%method : 보간 방법. nearest, bilinear, bicubic이 있음. 
%nearest : 최근접이웃 보간으로, 점이 속하는 픽셀 값이 출력 픽셀에 할당됨. 다른 픽셀은 고려되지 않음.
%bilinear : 출력 픽셀 값은 최근접 2x2 이웃 픽셀의 가중 평균.
%bicubic : default. 출력 픽셀 값은 최근접 4x4 이웃 픽셀의 가중 평균. 원래 범위를 벗어나는 픽셀 값을 생성할 수 있음.


%1) 픽셀 복제 방법 : 배율만큼 픽셀을 반복적으로 복사하는 방법. 확대 배율이 정수일 경우에만 사용할 수 있음.

f=imread('lena.jpg');
imre1=imresize(f, 3, 'nearest'); %픽셀 복제 방법을 이용해 영상을 세 배 확대
imre2=imresize(f, [256*3, 256*3], 'nearest'); %imre1과 같은 결과
imshow(f), figure, imshow(imre1), figure, imshow(imre2);
imshowpair(f, imre1, 'montage'); %한 화면에 두 영상의 실제 크기로 영상 출력

%픽셀 복제 방법으로 영상을 확대해서 볼 경우에는 결과 영상에서 계단 현상이 발생하는 것이 문제가 될 수 있음.
%계단 현상 : 컴퓨터 그래픽에서, 화면의 가장자리 부분이 매끄럽지 않게 계단처럼 보이는 현상. 애일리어싱(Aliasing)이라고 함.


%2) 역방향 사상과 양선형 보간법 
%역방향 사상과 양선형 보간법은 픽셀 복제 방법을 사용해 영상을 확대할 때 나타나는 계단 현상을 해결할 수 있음.

imre3=imresize(f, 3, 'bilinear'); %양선형 보간법을 이용해 영상을 세 배 확대
imshow(imre3);
imshowpair(imre1, imre3, 'montage');

%픽셀 복제 방법을 이용해 영상을 확대한 결과와 비교하면 계단 현상이 제거되어 부드러운 영상을 얻을 수 있다는 것을 확인할 수
%있었습니다.





%영상을 축소하는 방법
%1) 서브샘플링 : 축소하려는 배율만큼 건너뛰면서 픽셀값을 얻는 방법.
%ex) 가로 세로 각 방향으로 두 배씩 축소하고 싶을 경우, 모든 짝수 번째 행에서 짝수 번째 열의 픽셀값만 출력 영상에 복사함.

size=size(f); 
result1=f(2:2:size(1), 2:2:size(2)); %서브샘플링을 이용해 영상을 두 배 축소
result2=f(3:3:size(1), 3:3:size(2)); %서브샘플링을 이용해 영상을 세 배 축소
imshow(f), figure, imshow(result1), figure, imshow(result2);

%원본 영상을 바로 서브샘플링하면 영상의 세밀한 정보를 잃어버릴 수 있음.
%영상의 세밀한 정보를 잃어버리는 것을 방지하기 위해 먼저 원본 영상을 흐리게 한 다음에 축소하면 됨.

%영상을 흐리게 한 다음 축소
mask=ones(3);
mask=1/9*mask; %3*3크기의 회선 마스크 생성
y=filter2(mask, f);
y=uint8(y);
result3=y(2:2:size(1), 2:2:size(2)); %서브샘플링을 이용해 영상을 두 배 축소
result4=y(3:3:size(1), 3:3:size(2)); %서브샘플링을 이용해 영상을 세 배 축소
imshow(result3), figure, imshow(result4);
imshowpair(result2, result4, 'montage'); %영상을 흐리게 하지 않고 세 배 축소했을 때와 영상을 흐리게 한 다음에 세 배 축소했을 때 결과 비교


%2) 평균값 필터링 : 평균값 필터를 이용.
%영역 기반 처리에서 흐린 영상 생성을 위해 사용했던 평균값을 출력 영상에 복사한다는 것은 비슷한데, 
%차이점은 축소 연산에서는 필터 윈도우 전체를 평균값으로 대처함. 
%ex) 3*3 크기의 평균값 필터를 사용하여 영상을 축소하면 가로 세로 방향으로 세 배씩 축소되게 함.

%평균값 필터를 이용해 영역 기반 처리를 한 다음, 서브 샘플링 하기

f=imread('lena.jpg');
average_filter=fspecial('average', [3 3]); %3*3 크기의 평균값 필터 생성
k=filter2(average_filter, f);
k=uint8(k);
size=size(k);
k1=k(2:2:size(1), 2:2:size(2)); %평균값 필터를 이용해 영상을 두 배 축소
k2=k(3:3:size(1), 3:3:size(2)); %평균값 필터를 이용해 영상을 세 배 축소
imshow(k1), figure, imshow(k2);

%평균값 필터를 이용한 방법이 서브샘플링 방법에 비해 영상의 세밀한 부분을 잘 보존할 수 있다는 것을 확인할 수 있었습니다.


%3) 중간값 필터링 : 중간값 필터를 이용.
k=ordfilt2(f, 5, ones(3)); %3*3 크기의 중간값 필터를 이용해 중간값 필터링 수행
k1=k(2:2:size(1), 2:2:size(2)); %중간값 필터를 이용해 영상을 두 배 축소
k2=k(3:3:size(1), 3:3:size(2)); %중간값 필터를 이용해 영상을 세 배 축소
imshow(k1), figure, imshow(k2);





%영상을 회전
%imrotate 명령어를 사용해 회전. (전에 했던 것과 같음!)

%rote = imrotate(image, angle, 'method', 'crop');
%imrotate : 영상을 회전시켜주는 함수
%rote : imrotate명령어 사용 결과 출력되는 영상
%image : 원본 영상
%angle : 회전 각도. 양수값이 반시계 방향.
%method : nearest, bilinear, bicubic이 있음. method로 지정된 보간 방법을 사용하여 영상을 회전.
%nearest :  default. 최근접이웃 보간으로, 점이 속하는 픽셀 값이 출력 픽셀에 할당됨. 다른 픽셀은 고려되지 않음.
%bilinear : 출력 픽셀 값은 최근접 2x2 이웃 픽셀의 가중 평균.
%bicubic : 출력 픽셀 값은 최근접 4x4 이웃 픽셀의 가중 평균. 원래 범위를 벗어나는 픽셀 값을 생성할 수 있음.
%crop : 기존의 영상의 크기범위에서 영상을 회전시킴. 회전을 시키면 기존영상 외의 출력범위는 잘림. 'crop'을 입력하지
%않는다면 기존의 영상보다 커진 출력화면이 나오게 됨.

%nearest
imshow(imrotate(f, 30, 'nearest'));

%bilinear
imshow(imrotate(f, 30, 'bilinear'));

%bicubic
imshow(imrotate(f, 30, 'bicubic'));






%영상을 대칭 변환
%좌우대칭과 상하대칭 두 가지. (전에 파이썬으로 했던 것과 비슷)
%좌우대칭은 fliplr 명령어를 사용, 상하대칭은 flipud 명령어를 사용해 대칭 변환.

%lr=fliplr(image);
%fliplr : 영상을 좌우대칭하는 함수
%lr : fliplr명령어 사용 결과 출력되는 영상
%image : 원본 영상

%ud=flipud(image);
%flipud : 영상을 상하대칭하는 함수
%ud : flipud명령어 사용 결과 출력되는 영상
%image : 원본 영상

%영상 좌우대칭
lr=fliplr(f);
imshow(lr);

%영상 상하대칭
ud=flipud(f);
imshow(ud);
