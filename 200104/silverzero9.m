%matlab �����Լ��� histeq�� ����Ͽ� ������׷� ��Ȱȭ �ϱ� 

f=imread('lena.jpg');

%���� ������ ��� ���� ������׷��� ��Ȱȭ �Ͽ� ������ �� �����ϰ� ����� ���� histeq(f, n)���ɾ� ���
%f : ��Ȱȭ �ϰ��� �ϴ� ����
%n : �׷��� ������ ��, default���� 64. n�� 256�� ��� 256���� �׷��� ������ ����.
g=histeq(f, 256);

imshow(f), figure, imhist(f), figure, imshow(g), figure, imhist(g); %���� ����, ��� ���� ������׷� ���/ ��Ȱȭ�� ����, ��� ���� ������׷� ���