%Lab. 2-5
%학번 : 21812009, 이름 : 조은영

function result = mybwlabel(input, adjacency)
row=size(input, 1);
column=size(input, 2);
result=zeros([row, column]);

if adjacency ~= 8
    exit;
end

label=1;
for j=2:column-1
    for i=2:row
        if input(i,j) ~= 0
            if (result(i-1, j-1) == 0 && result(i-1, j) == 0 && result(i-1, j+1) == 0 && result(i,j-1) == 0)
                result(i,j)=label;
                label=label+1;
            else
                array=[result(i-1, j-1), result(i-1, j), result(i-1, j+1), result(i,j-1)];
                position=find(array~=0);
                num=min(array(position));
                result(i, j)=num;
                if input(i-1, j-1)==1
                    result(i-1,j-1)=num;
                end
                if input(i-1, j)==1
                    result(i-1,j)=num;
                end
                if input(i-1, j+1)==1
                    result(i-1,j+1)=num;
                end
                if input(i, j-1)==1
                    result(i,j-1)=num;
                end
            end
        end
    end
end

end


