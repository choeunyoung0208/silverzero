%컬러 영상에 대한 처리

%사용되는 함수
%rgb2hsv :  RGB 이미지의 빨간색, 녹색, 파란색 값을 HSV(HSI) 이미지의 색상, 채도, 명도 값으로 변환해줌.
%hsv2rgb :  HSV(HSI) 이미지의 색상, 채도, 명도 값을 RGB 이미지의 빨간색, 녹색, 파란색 값으로 변환해줌.

%RGB 컬러 영상에 대한 영상 처리 방법
%1) RGB 컬러 모델을 그대로 사용하는 방법
%빨강색 성분값만으로 구성된 영상, 초록색 성분값만으로 구성된 영상, 파랑색 성분값만으로 구성된 영상으로 분리한 다음
%각 성분에 대해 회선 마스크를 독립적으로 적용하고 난 뒤 합친 결과를 출력하면 됨.

%3*3 크기의 평균 마스크 적용
RGB=imread('test.jpg');
RGB_R=RGB(:, :, 1);
RGB_G=RGB(:, :, 2);
RGB_B=RGB(:, :, 3);
mask=fspecial('average');
imshow(RGB_R), figure, imshow(RGB_G), figure, imshow(RGB_B);

result_R2=filter2(mask, RGB_R);
result_R2=uint8(result_R2);
result_G2=filter2(mask, RGB_G);
result_G2=uint8(result_G2);
result_B2=filter2(mask, RGB_B);
result_B2=uint8(result_B2);
imshow(result_R2), figure, imshow(result_G2), figure, imshow(result_B2);

result_RGB2(:, :, 1)=result_R2;
result_RGB2(:, :, 2)=result_G2;
result_RGB2(:, :, 3)=result_B2;
imshow(RGB), figure, imshow(result_RGB2);
%a1=imfilter(RGB, mask)도 같은 결과


%11*11 크기의 평균 마스크 적용
mask11=fspecial('average', 11);

result_R2=filter2(mask11, RGB_R);
result_R2=uint8(result_R2);
result_G2=filter2(mask11, RGB_G);
result_G2=uint8(result_G2);
result_B2=filter2(mask11, RGB_B);
result_B2=uint8(result_B2);

result_RGB2(:, :, 1)=result_R2;
result_RGB2(:, :, 2)=result_G2;
result_RGB2(:, :, 3)=result_B2;
imshow(RGB), figure, imshow(result_RGB2);
%a2=imfilter(RGB, mask11)도 같은 결과


%2) HSI 컬러 모델로 변환하여 처리하는 방법
%H : 색상(Hue)
%S : 채도(Saturation)
%I : 밝기(Intensity)
%RGB 컬러를 HSI 컬러로 변환한 다음, 밝기 I에 대해 회선을 수행해 밝기를 변환한 다음에 RGB 컬러 공간으로 변환하면 됨. 
%(색상(H)과 채도(S)에 대해서는 아무런 작업을 수행하지 않음.)

RGB=imread('test.jpg');
HSI=rgb2hsv(RGB);
mask=fspecial('average');
mask11=fspecial('average', 11);
HSI_I=HSI(:, :, 3);

result_I=filter2(mask, HSI_I);
result_I2=filter2(mask11, HSI_I);

HSI1=HSI;
HSI2=HSI;

HSI1(:, :, 3)=result_I;
RGB1=hsv2rgb(HSI1);
HSI2(:, :, 3)=result_I2;
RGB2=hsv2rgb(HSI2);

b1=imfilter(RGB, mask);
b2=imfilter(RGB, mask11);
imshow(b1), figure, imshow(RGB1), figure, imshow(b2), figure, imshow(RGB2);