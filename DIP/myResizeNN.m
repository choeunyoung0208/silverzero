%Lab. 2-2 : Nearest neighbor interpolation
%학번 : 21812009, 이름 : 조은영

function outputimage=myResizeNN(inputimage,scalefactor)
a=size(inputimage);
b=round(a*scalefactor);

if length(a)==3
    outputimage=zeros([b(1), b(2), 3],'uint8');
    for k=1:3 %color image
        for i=1:b(1)
            for j=1:b(2)
                row=round(1/scalefactor * i);
                column=round(1/scalefactor *j);
                if row==0
                    row=1;
                end
                if column==0
                    column=1;
                end
                outputimage(i, j, k)=inputimage(row, column, k);
            end
        end
    end

else %grayscale image
    outputimage=zeros([b(1), b(2)],'uint8');
    for i=1:b(1)
        for j=1:b(2)
              row=round(1/scalefactor * i);
              column=round(1/scalefactor *j);
              if row==0
                  row=1;
              end
              if column==0
                  column=1;
              end
              outputimage(i, j)=inputimage(row, column);
        end
    end
end

end