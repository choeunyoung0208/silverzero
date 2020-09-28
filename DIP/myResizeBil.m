%Lab. 2-2 : Bilinear interpolation
%학번 : 21812009, 이름 : 조은영

function outputimage = myResizeBil(inputimage, scalefactor)

%// Get some necessary variables first
in_rows = size(inputimage,1);
in_cols = size(inputimage,2);
out_rows = scalefactor*in_rows;
out_cols = scalefactor*in_cols;

outputimage = zeros([round(out_rows), round(out_cols), size(inputimage, 3)], 'uint8');

 for k=1:size(inputimage, 3)
        for i=1:out_rows
            for j=1:out_cols
                r_f = i * (in_rows / out_rows);
                c_f = j * (in_cols / out_cols);
                r = floor(r_f);
                c = floor(c_f);
                if r==0
                    r=1;
                end
                if c==0
                   c=1;
                end
                if r>=in_rows
                    r=in_rows-1;
                end
                if c>=in_cols
                    c=in_cols-1;
                end
                delta_R = r_f - r;
                delta_C = c_f - c;
                outputimage(i, j, k) = uint8(inputimage(r,c,k)*(1 - delta_R)*(1 - delta_C) + inputimage(r+1,c,k)*(delta_R)*(1 - delta_C) + inputimage(r,c+1,k)*(1 - delta_R)*(delta_C) + inputimage(r+1, c+1, k)*(delta_R)*(delta_C));
            end
        end
 end
end