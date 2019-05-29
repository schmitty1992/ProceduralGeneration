clearvars
close all
clc

global MaxGridX;
global MaxGridY;
MaxGridX = 40;
MaxGridY = 20;

% Start with X x Y Grid
f = figure;
hold on
grid on
axis([0 MaxGridX 0 MaxGridY])
xticks(0:1:MaxGridX)
yticks(0:1:MaxGridY)
xticklabels([])
yticklabels([])

%- Pick Start Point
StartX = randi([0,floor(MaxGridX*0.25)])+0.5;
StartY = randi([0,floor(MaxGridY*0.25)])+0.5;

%- Pick End Point
EndX = randi([floor(MaxGridX*0.75),MaxGridX-1])+0.5;
EndY = randi([floor(MaxGridY*0.75),MaxGridY-1])+0.5;

%- Direction Vectors
N = {[0 1]};
E = {[1 0]};
S = {[0 -1]};
W = {[-1 0]};
keySet = {0, 1, 2, 3};
valueSet = [N, E, S, W];
dir = containers.Map(keySet,valueSet);

%- Plot Qualities
SaveGif = 0;
MarkerSize = 8;

%- Create Maze Path
i = 1;
point_vec = [StartX StartY];
filename='test.gif';
base_point = point_vec;
while i < (MaxGridX * MaxGridY)/4
    %- Check to see all surrounding areas except origin are still "walls"
    [new_point, base_point, Viable] = DigNextTunnel(dir,base_point,point_vec);
    
    if (Viable)
        pause(1e-4)
        plot([base_point(1) new_point(1)],[base_point(2) new_point(2)],...
            '-k','MarkerFaceColor','k','MarkerSize',MarkerSize,'LineWidth',6)
        point_vec(end+1,:) = new_point;
    end
    
    if (SaveGif)
        %- Capture the plot as an image
        frame = getframe(f);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        % Write to the GIF File
        if i == 1
            imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTIme',1e-10);
        else
            imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1e-10);
        end
    end
      
      i = i + 1;
end

% plot(StartX,StartY,'ok','MarkerFaceColor','g','MarkerSize',MarkerSize+2)
% plot(EndX,EndY,'ok','MarkerFaceColor','r','MarkerSize',MarkerSize+2)

RoomPlacement
