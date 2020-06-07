function result = histogrameq(image)

[m,n]=size(image);

A=imhist(image);
B=cumsum(A);

for i=1:m
    for j=1:n
        pix=double(image(i,j));
        result(i,j)=((255/(m*n))*B(pix+1));
    end
end
result=uint8(result);