clearvars
close all
clc

global MaxGridX;
global MaxGridY;
MaxGridX = 30;
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
    [new_point, base_point, Viable] = DigNextTunnel(base_point,point_vec);
    
    if (Viable)
        if (AnimateDraw)
            pause(1e-2)
            delete(draw_base_point)
            delete(draw_new_point)
        end
        plot([base_point(1) new_point(1)],[base_point(2) new_point(2)],...
            '-k','MarkerFaceColor','k','MarkerSize',MarkerSize,'LineWidth',6)
        if (AnimateDraw)
            draw_base_point = plot(base_point(1),base_point(2),...
                'ok','MarkerFaceColor','g','MarkerSize',MarkerSize);
            draw_new_point = plot(new_point(1),new_point(2),...
                'ok','MarkerFaceColor','c','MarkerSize',MarkerSize);
        end
%         delete(draw_point)
        point_vec(end+1,:) = new_point;
        base_point = new_point;
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

delete(draw_base_point)
delete(draw_new_point)

RoomPlacement
