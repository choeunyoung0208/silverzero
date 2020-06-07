f=imread('lena.jpg'); %이미지 파일을 읽어 변수 f에 저장
imshow(f); %원본 출력

%imrotate(f, angle) 명령을 이용해 주어진 영상 회전. 
%f : 회전시키고자 하는 영상 
%angle : 영상을 얼마나 회전할지 결정해줌. 
%angle=0 : 회전하지 않음
%angle>0 : 반시계방향으로 angle값 만큼 회전
%angle<0 : 시계방향으로 angle값 만큼 회전

g1=imrotate(f,45); %주어진 영상을 반시계방향으로 45도 회전
figure, imshow(g1); %반시계방향으로 45도 회전시킨 영상 출력

g2=imrotate(f,90); %주어진 영상을 반시계방향으로 90도 회전
g8=imrotate(g1,45); %f를 반시계방향으로 45도 회전시킨 결과를 g1에할당한 것을 바탕으로 45도만큼 더 회전시키는 것 또한 반시계방향으로 90도 회전된 영상 출력될 수 됨

g3=imrotate(f,180); %주어진 영상을 반시계방향으로 180도 회전

g4=imrotate(f,-45); %주어진 영상을 시계방향으로 45도 회전

g5=imrotate(f, -90); %주어진 영상을 시계방향으로 90도 회전

g6=imrotate(f, -180); %주어진 영상을 시계방향으로 180도 회전 

figure, imshow(g2), figure, imshow(g3), figure, imshow(g4), figure, imshow(g5), figure, imshow(g6); %영상들을 모두 출력 
%출력 결과 g2와 g5의 값이 같음을 확인 할 수 있었음.

g7=imrotate(f, 315); %주어진 영상을 반시계방향으로 315도 회전

imshow(g7), figure, imshow(g4); %g7과 g4을 같이 출력해 본 결과 값이 같음을 확인 할 수 있었음.
