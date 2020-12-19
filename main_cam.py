# 구동하는데 필요한 라이브러리 불러옴 (keras, numpy, cv2, datetime, time, playsound)

# 영상처리에 사용되는 라이브러리들
from tensorflow.keras.applications.mobilenet_v2 import preprocess_input
from tensorflow.keras.models import load_model
import numpy as np
import cv2

# 시간관련 라이브러리
import datetime
import time

# LED 제어를 하는데 사용되는 라이브러리
import serial
import socket

# 마스크 미착용시 경보음을 울리기 위해 사용되는 라이브러리
from playsound import playsound


HOST = '192.168.0.94' # 서버의 주소
PORT = 12345 # 서버에서 지정해 놓은 포트 번호

# 소켓 객체를 생성한다.
# 주소 체계(address family)로 IPv4, 소켓 타입으로 TCP 사용합니다.
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# 지정한 HOST와 PORT를 사용하여 서버에 접속합니다.
client_socket.connect((HOST, PORT))

#ArduinoSerial=serial.Serial('COM6', 9600)

facenet = cv2.dnn.readNet('models/deploy.prototxt', 'models/res10_300x300_ssd_iter_140000.caffemodel') #
model = load_model('models/mask_detector.model')

cap = cv2.VideoCapture(0) # SBC와 연결된 카메라 장치를 불러옴
i = 0
tf=''

while cap.isOpened(): # 카메라 장치가 연결되어있으면 실행(영상 캡쳐 객체 cap이 정상적으로 open되었으면 실행)
	ret, img = cap.read() # 영상의 한 프레임씩 읽음. 프레임을 제대로 읽으면 ret값이 True, 실패하면 False값이 할당됨. img에 읽은 프레임이 할당됨.
	if not ret : # 영상의 프레임을 제대로 읽지 못 한 경우 종료.
		break

	h, w = img.shape[:2] # 영상의 해상도(높이, 폭)를 h, w에 할당함

	blob = cv2.dnn.blobFromImage(img, scalefactor=1., size=(300, 300), mean=(104., 177., 123.))
	# img를 가지고 4차원의 blob을 만듦
	# mean subtraction : RGB 값의 일부를 제외해서 dnn이 분석하기 쉽게 단순화해주는 것
	# img : blob을 통해 사전 처리하기를 원하는 이미지
	# scalefactor : 평균빼기를 시전한 후 스케일할 값 (R-ur)/a에서 a값
	# size : 공간 크기
	# mean : 평균 빼기 값

	facenet.setInput(blob) # 모델에 들어가는 input
	dets = facenet.forward() # 결과를 inference

	result_img = img.copy()

	for i in range(dets.shape[2]):
		confidence = dets[0, 0, i, 2]
		if confidence < 0.5:
			continue

		x1 = int(dets[0, 0, i, 3] * w)
		y1 = int(dets[0, 0, i, 4] * h)
		x2 = int(dets[0, 0, i, 5] * w)
		y2 = int(dets[0, 0, i, 6] * h)

		face = img[y1:y2, x1:x2]

		try :
			face_input = cv2.resize(face, dsize=(224,224))
			face_input = cv2.cvtColor(face_input, cv2.COLOR_BGR2RGB)
			face_input = preprocess_input(face_input)
			face_input = np.expand_dims(face_input, axis=0)
			mask, nomask = model.predict(face_input).squeeze()

		except Exception as e:
			print(str(e))

		if mask > nomask :
			color = (0, 255, 0)#마스크를 착용한 사람은 초록색으로 사각형을 나타낸다
			label = "Mask %d%%" % (mask * 100)#마스크를 착용한 확률을 나타낸다
			#tf='1'아두이노에
			#tf=tf.encode('utf-8')
			#ArduinoSerial.write('1')#마스크를 착용했다고 led에 전송한다
			# 메시지를 전송합니다.
			client_socket.sendall('1'.encode())
		else :
			color = (0, 0, 255)#마스크를 착용한 사람은 빨간색으로 사각형을 나타낸다
			label = "No mask %d%%" % (nomask * 100)#마스크를 착용하지 확률을 나타낸다
			now = datetime.datetime.now().strftime("%d_%H-%M-%S")#현재 시간을 가져온다
			cv2.imwrite("C:/Users/lattepanda/Desktop/data/"+str(now)+".jpg", img)#캡처한 사진을 현재시간을 제목으로 저장한다
			#tf='0'
			#tf = tf.encode('utf-8')
			#ArduinoSerial.write(tf)#마스크를 착용하지 않았다고 led에 전송한다
			# 메시지를 전송합니다.
			client_socket.sendall('0'.encode())
			playsound("sound2.mp3",block=False)#음성파일을 재생한다
			time.sleep(1.5)


		cv2.rectangle(result_img, pt1=(x1,y1), pt2=(x2,y2), thickness=2, color=color, lineType=cv2.LINE_AA) # 얼굴을 관심영역으로 설정한다
		cv2.putText(result_img, text=label, org=(x1,y1-10), fontFace=cv2.FONT_HERSHEY_SIMPLEX, fontScale=0.8,
				color=color, thickness=2, lineType=cv2.LINE_AA) # 관심영역위에 마스크착용여부 확률을 나타낸 label를 설정한다

	cv2.imshow('img',result_img) # 설정된 관심영역과 label을 출력한다

	if cv2.waitKey(1) & 0xFF == ord('q'):#'q'를 누르면 프로그램이 종료된다
		break











# 메시지를 수신합니다.
#data = client_socket.recv(1024)
#print('Received', repr(data.decode()))

# 소켓을 닫습니다.
#client_socket.close()