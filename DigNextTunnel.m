function [new_point, base_point, Viable] = DigNextTunnel(dir,point_vec)
global MaxGridX MaxGridY

Continue = 0;
UsedDirections = [];
% fprintf('Origin Point: [%2.1f %2.1f] \n',...
%     point_vec(end,1),point_vec(end,2))
base_point = [point_vec(end,1) point_vec(end,2)];
[OriginIndex, ~] = size(point_vec);
while (~Continue)
    Viable = 1;
    
    %- Select Random Direction to Dig (Equal Distribution for now)
    % Up - 0
    % Right - 1
    % Down - 2
    % Left - 3
    temp = rand();
    if (temp < 0.2)
        direction = 0;
    elseif (temp < 0.4)
        direction = 2;
    elseif (temp < 0.7)
        direction = 1;
    elseif (temp < 1.0)
        direction = 3;
    end
    
    %     direction = randi([0,3]);
    while any(direction == UsedDirections)
        %         direction = randi([0,3]);
        temp = rand();
        if (temp < 0.1)
            direction = 0;
        elseif (temp < 0.2)
            direction = 2;
        elseif (temp < 0.6)
            direction = 1;
        elseif (temp < 1.0)
            direction = 3;
        end
    end
    new_point = [point_vec(OriginIndex,1) point_vec(OriginIndex,2)] + dir(direction);
    
    %- Check Viable Point
    if (new_point(1) < 0 || new_point(1) > MaxGridX) ||...
            (new_point(2) < 0 || new_point(2) > MaxGridY)
%         disp('ERR: Outside of bounds, need new point')
        Viable = 0;
    end
    
    [r,~] = size(point_vec);
    for i = 1:r
        if all(new_point == point_vec(i,:))
%             disp('ERR: New point already exists in stack')
            Viable = 0;
        end
    end
    
    if (Viable)
        Continue = 1;
    else
        UsedDirections(end+1) = direction;
    end
    
    if length(UsedDirections) == 4
%         disp('**All Directions Checked, Non-Viable.**')
        UsedDirections = [];
        OriginIndex = OriginIndex - 1;
%         fprintf('New Origin Point: [%2.1f %2.1f] \n',...
%             point_vec(OriginIndex,1),point_vec(OriginIndex,2))
        base_point = [point_vec(OriginIndex,1) point_vec(OriginIndex,2)];
    end
end

end

