%3)Robot Animation

%setting frames speed
d=2;
j=1:d:length(T);

%generating images in 2D
figure;
for i=1:length(j)-1
    hold off;
    plot([x1(j(i)) x2(j(i)) x3(j(i))], [y1(j(i)) y2(j(i)) y3(j(i))], 'o', [0 x1(j(i))], [0 y1(j(i))], 'k', [x1(j(i)) x2(j(i)) x3(j(i))], [y1(j(i)) y2(j(i)) y3(j(i))], 'k');
    title('Motion of 3DOF Robotic Arm');
    xlabel('x');
    ylabel('y');
    axis([-3 3 -3 3]);
    grid;
    hold on;
    MM(i)=getframe(gcf);
end
drawnow;

%exporting to 'mpg' movie
mpgwrite(MM, 'RGB', '3DOF_rob.mpg');