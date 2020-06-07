%0~1의 값을 가지도록 mapping

f=imread('lena.jpg'); %영상을 읽어 f에 할당
f1=im2double(f); %f에 저장된 값들을 double형으로 변환해서 f1에 할당
minimum=min(min(f1)); %f1의 최솟값. f1의 차원이 2차원이므로 min()명령어를 두번 사용함
maximum=max(max(f1)); %f1의 최댓값. f1의 차원이 2차원이므로 min()명령어를 두번 사용함
[m, n]=size(f); %f의 행과 열을 변수 m, n에 할당
g=zeros(m, n); %m, n을 이용하여 f와 같은 크기를 가지는 행렬 생성
g=(f1-minimum)/(maximum-minimum); %원본 영상의 픽셀값들, 최솟값, 최댓값을 이용해 원본 영상을 평활화
imshow(g), figure, imshow(f), figure, imhist(g), figure, imhist(f); %원본 영상과 평활화된 영상을 출력하고, 히스토그램도 같이 출력
