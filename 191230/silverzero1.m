f=imread('lena.jpg'); %lena.jpg 파일을 읽어 변수 f에 행렬 형태로 저장
g=imread('lena_g.jpg'); %lena_g.jpg 파일을 읽어 변수 g에 행렬 형태로 저장
imshow(f) %lena.jpg 를 화면에 출력
figure, imshow(g) %lena.jpg 를 화면에 출력한 상태에서 lena_g.jpg 를 출력
%원래는 lena.jpg와 lena_g.jpg 사진이 같아보였으나 matlab에서 출력해본 결과 같은 사진이 아님을 확인할 수 있었음
%matlab의 현재 폴더에서 lena.jpg와 lena_g.jpg를 더블클릭 하여 비교해 본 결과 lena_g.jpg에 colormap이라는 것이 생겼음을 확인.
%colormap은 3열로 표시되며, 첫번째 열은 R, 두번째 열은 G, 세번째 열은 B를 나타냄. 범위는 0<=colormap<=1 까지.
[X,map]=imread('lena_g.jpg');
figure, imshow(X,map)
%imshow(X,map)와 [A,map] = imread(___)를 이용하여 map에 colormap을 할당하고, 다시 lena_g.jpg를 출력해본 결과 lena.jpg와 같은 사진이 출력됨.
%colormap이 생성되는 이유는 1시간 27분동안 찾아봤는데... 찾지 못했습니다.... 다시 찾으러 가보겠습니다....
