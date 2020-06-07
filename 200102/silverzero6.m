f=imread('lena.jpg'); %이미지를 읽어 변수 f에 행렬로 할당

%imadjust(f, [low_in high_in], [low_out high_out], gamma) 명령어를 이용하여 주어진 영상,f를 밝기 변환
%[low_in high_in], [low_out high_out]의 default 값은 [0 1] 
%low_out > high_out 이면 밝기가 반전돼서 출력됨
%gamma의 default 값은 1

g1=imadjust(f, [0 1], [0 0.5]); %영상 f의 밝기 값 0~1사이의 값을 0~0.5사이의 값으로 매핑 (원본보다 더 어둡게 출력)

g2=imadjust(f, [0 1], [0.5 0]); %영상 f의 밝기 값 0~1사이의 값을 0.5~0사이의 값으로 매핑. 0.5>0이므로 밝기가 반전돼서 출력됨 (원본보다 더 어둡게 출력되면서 밝기 반전)

g3=imadjust(f, [0 1], [0.5 1]); %영상 f의 밝기 값 0~1사이의 값을 0.5~1사이의 값으로 매핑 (원본보다 더 밝게 출력)

g4=imadjust(f, [0 1], [1 0.5]); %영상 f의 밝기 값 0~1사이의 값을 1~0.5사이의 값으로 매핑. 1>0.5이므로 밝기가 반전돼서 출력됨. (원본보다 더 밝게 출력되면서 밝기 반전)

imshow(f), figure, imshow(g1), figure, imshow(g2), figure, imshow(g3), figure, imshow(g4); %모든 영상들을 출력

%원본 사진의 밝기 분포를 확인하고 싶어 영상 데이터 클래스를 확인해 보니 0~255사이로 출력되는 uint8인 것을 확인했음. 이 값을 double형으로 변환한 값이 바로 밝기가 됨
h=im2double(f); %영상 f의 밝기 분포를 변수 h에 행렬 형태로 저장
