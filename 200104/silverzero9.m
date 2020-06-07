%matlab 내장함수인 histeq를 사용하여 히스토그램 평활화 하기 

f=imread('lena.jpg');

%원본 영상의 밝기 분포 히스토그램을 평활화 하여 영상을 더 선명하게 만들기 위해 histeq(f, n)명령어 사용
%f : 평활화 하고자 하는 영상
%n : 그레이 레벨의 수, default값은 64. n이 256인 경우 256개의 그레이 레벨을 가짐.
g=histeq(f, 256);

imshow(f), figure, imhist(f), figure, imshow(g), figure, imhist(g); %원본 영상, 밝기 분포 히스토그램 출력/ 평활화된 영상, 밝기 분포 히스토그램 출력