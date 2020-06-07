import cv2 #openCV를 import

#이미지 파일을 읽어 변수에 할당 : cv2.imread('filename', flag)
#filename : 읽기를 원하는 이미지 파일
#flag : 이미지 파일을 읽을때 옵션(cv2.IMREAD_COLOR, cv2.IMREAD_GRAYSCALE, cv2.IMTREAD_UNCHANGED 이렇게 세가지가 있음)
#cv2.IMREAD_COLOR : 이미지 파일을 color로 읽음, 투명한 부분은 무시됨
#cv2.IMREAD_GRAYSCALE : 이미지 파일을 Grayscale로 읽음
#cv2.IMREAD_UNCHANGED : 이미지 파일을 alphal channel까지 포함해 읽음
color = cv2.imread('lena_g.jpg', cv2.IMREAD_COLOR) #lena_g.jpg를 color로 읽어들임
gray = cv2.imread('lena_g.jpg', cv2.IMREAD_GRAYSCALE) #lena_g.jpg를 grayscale로 읽어들임
unchanged = cv2.imread('lena_g.jpg', cv2.IMREAD_UNCHANGED) #Lena_g.jpg를 alpha channel 까지 포함해 읽어들임

#읽은 이미지 파일을 화면에 출력 : cv2.imshow('title',image)
cv2.imshow('color',color) #color를 화면에 출력
cv2.imshow('gray', gray) #gray를 화면에 출력
cv2.imshow('unchanged', unchanged) #unchanged를 화면에 출력

cv2.waitKey(0) #키보드 입력을 대기하는 함수, ()안의 값이 0이면 키입력까지 무한 대기, 특정시간동안 대기하려면 ms값을 넣어주면 됨