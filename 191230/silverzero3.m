f=imread('lena.jpg'); %lena.jpg 파일을 읽어 f라는 변수에 행렬로 저장

size(f) %lena.jpg 파일의 픽셀 크기를 확인. 이를 통해 lena.jpg 파일의 픽셀은 256*256으로 구성됨을 확인 할 수 있었음

imshow(f) %원본을 출력

%수직 반전된 이미지 출력
flip=f(end:-1:1,:); %flip이라는 변수에 행렬 f의 256번째 행부터 1번째 행까지, 모든열에 대한 값을 할당.

%부분 캡쳐된 이미지 출력
capture=f(50:end-50, 50:end-50); %capture라는 변수에 행렬 f의 50번째 행부터 end(256)-50=206번째 행, 50번째 열부터 206번째 열에 대한 값을 할당.

%부표본화된 이미지 출력
subsample=f(1:2:end, 1:2:end); %subsample이라는 변수에 행렬 f의 홀수행과 홀수열에 해당되는 값을 할당.

figure, imshow(flip), figure, imshow(capture), figure, imshow(subsample);

%원본 이미지의 중간에서의 수평, 수직 스캔
plot(f(128,:)); %행렬 f의 중간 행인 128번째 행에서 수평으로 스캔한 것을 그래프로 나타냄.
plot(f(:,128)); %행렬 f의 중간 열인 128번째 열에서 수직으로 스캔한 것을 그래프로 나타냄.