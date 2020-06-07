#영상 밝기 변환

import cv2
import numpy as np

image1=cv2.imread('lena.jpg')
image2=cv2.imread('lena_c.png')


#영상 크기 출력
print(image1.shape) #(256, 256, 3)
print(image2.shape) #(512, 512, 3)


#영상 더하기
a1=np.uint8(np.full((256, 256, 3), 50)) #(256, 256, 3)크기를 가지고, 원소들의 값이 모두 50인 행렬 생성
#a1=np.full((256, 256, 3), 50, dtype=np.uint8) 명령어도 같은 결과를 줌

b1=np.uint8(np.full((512, 512, 3), 50)) #(512, 512, 3)크기를 가지고, 원소들의 값이 모두 50인 행렬 생성
#b1=np.full((512, 512, 3), 50, dtype=np.uint8) 명령어도 같은 결과를 줌

image1_result1=cv2.add(image1, a1)
image2_result1=cv2.add(image2, b1)

cv2.imshow('lena + 50', image1_result1) #밝기 50 증가 결과 출력
cv2.imshow('lena_c + 50', image2_result1) #밝기 50 증가 결과 출력
cv2.waitKey(0)


#영상 빼기
image1_result2=cv2.subtract(image1, a1)
image2_result2=cv2.subtract(image2, b1)

cv2.imshow('lena - 50', image1_result2) #밝기 50 감소 결과 출력
cv2.imshow('lena_c - 50', image2_result2) #밝기 50 감소 결과 출력
cv2.waitKey(0)


#영상을 파일로 출력
cv2.imwrite('lena + 50.jpg', image1_result1)
cv2.imwrite('lena_c + 50.jpg',  image2_result1)
cv2.imwrite('lena - 50.jpg', image1_result2)
cv2.imwrite('lena_c - 50.jpg', image2_result2)