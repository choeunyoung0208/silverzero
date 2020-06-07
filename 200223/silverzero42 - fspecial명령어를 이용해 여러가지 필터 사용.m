%fspecial() 명령어를 이용해 여러가지 필터 마스크 영상을 만들고 적용해보기(한 번씩 써보면 좋을 것 같아서 해봤습니다!)

%h=fspecial('type', parameters)
%fspecial : 필터 마스크 영상을 만드는 함수
%h : fspecial명령어 사용 결과 만들어 지는 필터 마스크

%parameters : default값은 3*3 크기. parameters는 [행, 열] 또는 상수로 입력 가능.
%[행, 열] : 마스크 행렬의 크기를 결정함.
%상수 : 정방행렬(정사각행렬)을 의미함.

%type : 여러가지 존재. 'average', 'disk', 'gaussian', laplacian', 'log',
%'motion', 'prewitt', 'sobel', 'unsharp'
%average : 평균 필터
%disk : 원형 평균 필터
%gaussian : 가우시안 저역통과 필터
%laplacian : 라플라시안 필터
%log : 라플라시안의 가우시안 필터
%motion : 카메라의 선형 모션 근사화 필터
%prewitt : Prewitt 수평 모서리 강조 필터
%sobel : Sobel 수평 모서리 강조 필터
%unsharp : unsharp 필터

%평균 필터
 f=imread('lena.jpg');
h_average=fspecial('average');
result_average=filter2(h_average, f);
result_average=uint8(result_average);
imshow(result_average);

%원형 평균 필터
h_disk=fspecial('disk');
result_isk=filter2(h_disk, f);
result_disk=uint8(result_disk);
imshow(result_disk);

%가우시안 저역통과 필터
h_gaussian=fspecial('gaussian');
result_gaussian=filter2(h_gaussian, f);
result_gaussian=uint8(result_gaussian);
imshow(result_gaussian);

%라플라시안 필터
h_laplacian=fspecial('laplacian');
result_laplacian=filter2(h_laplacian, f);
result_laplacian=uint8(result_laplacian);
imshow(result_laplacian);

%라플라시안의 가우시안 필터
h_log=fspecial('log');
result_log=filter2(h_log, f);
result_log=uint8(result_log);
imshow(result_log);

%카메라의 선형 모션 근사화 필터
h_motion=fspecial('motion');
result_motion=filter2(h_motion, f);
result_motion=uint8(result_motion);
imshow(result_motion);

%Prewitt 수평 모서리 강조 필터
h_prewitt=fspecial('prewitt');
result_prewitt=filter2(h_prewitt, f);
result_prewitt=uint8(result_prewitt);
imshow(result_prewitt);

%Sobel 수평 모서리 강조 필터
h_sobel=fspecial('sobel');
result_sobel=filter2(h_sobel, f);
result_sobel=uint8(result_sobel);
imshow(result_sobel);

%unsharp 필터
h_unsharp=fspecial('unsharp');
result_unsharp=filter2(h_unsharp, f);
result_unsharp=uint8(result_unsharp);
imshow(result_unsharp);