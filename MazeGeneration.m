clearvars -except err
close all
clc

global MaxGridX;
global MaxGridY;
MaxGridX = 30;
MaxGridY = 20;

% Start with X x Y Grid
f = figure('units','normalized','outerposition',[0.1 0.1 0.8 0.8]);
hold on
grid on
axis([0 MaxGridX 0 MaxGridY])
xticks(0:1:MaxGridX)
yticks(0:1:MaxGridY)
xticklabels([])
yticklabels([])

% Initialize Map
Step = 1;
for i = 1:Step:MaxGridX
    for j = 1:Step:MaxGridY
        Map(i,j) = Tile;
        Map(i,j) = CreateCell(Map(i,j),i-(Step/2),j-(Step/2));
        DisplayWall(Map(i,j))
    end
end

%- Allocate Direction Distribution
Choice = 3;
switch Choice
    case 0 % Equal
        DirectionDistribution = [0.25 0.25 0.25 0.25];
    case 1 % Favor East/West
        DirectionDistribution = [0.2 0.3 0.2 0.3];
    case 2 % Favor North/South
        DirectionDistribution = [0.3 0.2 0.3 0.2];
    case 3 % Strongly Favor East/West
        DirectionDistribution = [0.1 0.4 0.1 0.4];
    case 4 % Strongly Favor North/South
        DirectionDistribution = [0.4 0.1 0.4 0.1];
end

%- Pick Start Point
StartX = randi([3,floor(MaxGridX*0.25)])+0.5;
StartY = randi([3,floor(MaxGridY*0.25)])+0.5;

%- Pick End Point
EndX = randi([floor(MaxGridX*0.75),MaxGridX-6])+0.5;
EndY = randi([floor(MaxGridY*0.75),MaxGridY-4])+0.5;

%- Plot Qualities
AnimateDraw = 0;
SaveGif = 0;
MarkerSize = 8;

%- Create Maze Path
i = 1;
point_vec = [StartX StartY];
filename='test.gif';
base_point = point_vec;
draw_base_point = [];
draw_new_point = [];
while i < (MaxGridX * MaxGridY)/4
    %- Check to see all surrounding areas except origin are still "walls"
    [new_point, base_point, Map, Viable] =...
        DigNextTunnel(base_point,point_vec,DirectionDistribution,Map);
    
    if (Viable)
        if (AnimateDraw)
            pause(1e-12)
        end
        point_vec(end+1,:) = new_point;
        base_point = new_point;
    end
    
    if (SaveGif)
        if (mod(i,4) == 0 || i == 1)
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
    end
    
    i = i + 1;
end

RoomPlacement