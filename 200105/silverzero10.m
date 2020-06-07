%Equalization이란 영상의 모든 그레이 레벨 값의 빈도수를 비슷하게 만드는 것
%uint8의 경우 그레이 레벨의 범위는 0~255로 총 256개를 가짐

%명령창

f=imread('lena.jpg');

%[counts,binLocations] = imhist(f) 명령어를 사용해 영상 f의 각 그레이 레벨에 해당되는 빈도수(픽셀수) 확인
%counts : 히스토그램 도수(각 그레이 레벨에 해당되는 빈도수(픽셀수))
%binLocations : Bin 위치(영상 f의 그레이 레벨 스펙트럼)
%f : 평활화될 영상
[counts, binLocations]=imhist(f); %원본 영상의 각 그레이 레벨에 해당되는 픽셀수 확인

a=size(binLocations); %binLocations의 크기를 계산. 결과 a(1)=256, a(2)=1이 나옴.

bar(binLocations, counts); title('원본 영상'); %영상 f의 밝기분포 히스토그램을 막대 그래프 형태로 출력

figure, bar(binLocations, make_histeq(f, a(1)-1, counts)); title('평활화된 영상'); 
%평활화된 영상 f의 밝기분포 히스토그램을 막대 그래프 형태로 출력

----------------------------------------------------------------------------------------------------------------------
%편집기

%matlab 내장함수 histeq와 같은 역할을 하는 함수 생성

function eq = make_histeq(image, num, counts)
%image : 평활화될 영상

%num : 최대 그레이 레벨
%ex) 그레이 레벨의 범위가 0~255인 경우 
%num=255

%count : num의 각 요소에 해당되는 빈도수
%ex) count=[0 1 0 0 1...]인 경우 
%num(1), num(3), num(4)에 해당하는 픽셀의 개수가 0개 
%num(2), num(5)에 해당하는 픽셀의 개수가 1개

gray_level=0:1:num; 
%가질 수 있는 그레이 레벨 범위는 0~num(최대 그레이 레벨)까지의 정수를 가지므로, colon operator를 사용해 가질 수 있는 그레이 레벨 범위를 생성.
gray_level2=zeros(1, num+1); %변환된 그레이 레벨 값을 저장하기 위한 공간 생성. 모든 요소의 값이 0인 1행 num+1열을 가지는 열벡터 생성.
total_pixel_number=sum(counts(:)); %그레이 레벨 0~num까지 각각의 빈도수를 모두 합친 것(=총 픽셀수) 
accumulated_sum=zeros(1, num+1); %i번째 까지의 빈도수 누적합을 저장하기 위한 공간 생성. 
eq=zeros(1, num+1); %평활화된 그레이 레벨값 각각에 해당되는 픽셀수를 저장하기 위한 공간 생성.

%누적합 계산
accumulated_sum(1)=counts(1); %첫번째 까지의 빈도수 누적합 = 첫번째 빈도수와 같음
for i=2:num+1 %그레이 레벨의 범위는 0~num(최대 그레이 레벨 수). 따라서 num+1개의 요소를 가짐.
    accumulated_sum(i)=accumulated_sum(i-1)+counts(i); %i번째 까지의 빈도수 누적합 = i-1번째 까지의 빈도수 누적합 + i번째 빈도수
end

%변환된 그레이 레벨 계산(평활화된 그레이 레벨 계산)
%i번째에서 변환된 그레이 레벨값 = (그레이 레벨 개수-1/총 픽셀수)*(i번째 까지의 빈도수 누적합)을 한 결과를 반올림 하여 정수화
%따라서 i번째에서 변환된 그레이 레벨값 = ((num)/sum(counts(:))*(accumulated_sum(i))의 결과를 반올림해서 나온 정수

%반올림 하기 위해 round(X,N)명령어 사용. 
%X : 반올림 할 대상
%N > 0: 소수점 N번째 자릿수로 반올림
%ex) N=1이고 X=1.2345일 경우, 소수점 첫번째 자리까지 반올림 => 1.2의 결과가 나옴
%N = 0: 가장 가까운 정수로 반올림
%ex) N=1이고 X=1.2345일 경우, 가장 가까운 정수로 반올림 => 1의 결과가 나옴

for i=1:num+1 %그레이 레벨의 범위는 0~num(최대 그레이 레벨). 따라서 num+1개의 요소를 가짐.
    gray_level2(i)=round((num/total_pixel_number)*(accumulated_sum(i)), 0); %변환된 그레이 레벨 값 계산
end

for i=1:num+1
    eq(gray_level2(i)+1)=eq(gray_level2(i)+1)+counts(i); 
    %평활화된 그레이 레벨값 각각에 해당되는 픽셀수 계산. 
    %여기서 1을 더해주는 이유는 그레이 레벨의 범위가 0~num이므로, 
    %eq라는 열벡터의 첫번째 요소가 그레이 레벨 0을 가지는 픽셀수기 때문. 
    %따라서 gray_level2(i)의 레벨을 가지는 픽셀수는 eq라는 열벡터의 gray_level2(i)+1번째 요소가 됨.
end

end




%equalized image : imhist, imshow 오류
%직접 만든 함수를 사용해서 평활화한 결과 그래프와 이전에 histeq명령어를 사용해서 평활화한 결과 그래프를 비교해보니 똑같은 것 같기도 하고.. 
%약간 다른 것 같기도 합니다... 



%교수님,,,이걸 보실진 모르겠지만... 혹시나 보시게 된다면... 제가 종강하고나서 시도때도없이 계속먹었더니..턱에 무리가 갔는지... 
%턱이 아프더라구요.......그래서 내일 병원을 가야될 것 같아서...내일하려고 했던것들 미리 올립니다..ㅠㅠ 화요일날 열심히 하겠습니다..!!!!!!
