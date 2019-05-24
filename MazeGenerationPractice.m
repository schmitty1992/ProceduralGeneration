clearvars
close all
clc

MaxGridX = 30;
MaxGridY = 30;

% Start with X x Y Grid
figure
hold on
grid on
axis([0 MaxGridX 0 MaxGridY])
xticks(0:2:MaxGridX)
yticks(0:2:MaxGridY)

%- Pick Start Point
StartX = 0;
StartY = round(rand()*(MaxGridY-2))+1;
plot(StartX,StartY,'ok','MarkerFaceColor','k','MarkerSize',4)


%- Create Maze Path
point_vec = [StartX StartY];
for i = 1:10
    if (i ==1)
        %- First Move, Move Right
        point_vec(end+1,:) = [StartX+1 StartY];
    else
        %- Select Random Direction to Dig (Equal Distribution for now)
        % Up - 0
        % Right - 1
        % Down - 2
        % Left - 3
        direction = round(rand()*3);
        
        %- Check to see all surrounding areas except origin are still "walls"
        switch direction
            case 0
                Viable = 1;
                new_point = [point_vec(end,1) point_vec(end,2)+1];
                if new_point(1) < MaxGridX && new_point(1) > 0 &&...
                        new_point(2) < MaxGridY && new_point(2) > 0
                    check_left = [new_point(1)-1 new_point(2)];
                    for j = 1:point_vec
                        if check_left == point_vec(j,:) &&...
                                check_left(1) < MaxGridX && check_left(1) > 0 &&...
                                check_left(2) < MaxGridY && check_left(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                    check_right = [new_point(1)+1 new_point(2)];
                    for j = 1:point_vec
                        if check_right == point_vec(j,:) &&...
                                check_right(1) < MaxGridX && check_right(1) > 0 &&...
                                check_right(2) < MaxGridY && check_right(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                    check_up = [new_point(1) new_point(2)+1];
                    for j = 1:point_vec
                        if check_up == point_vec(j,:) &&...
                                check_up(1) < MaxGridX && check_up(1) > 0 &&...
                                check_up(2) < MaxGridY && check_up(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                else
                    Viable = 0;
                end
            case 1
                Viable = 1;
                new_point = [point_vec(end,1)+1 point_vec(end,2)];
                if new_point(1) < MaxGridX && new_point(1) > 0 &&...
                        new_point(2) < MaxGridY && new_point(2) > 0
                    check_right = [new_point(1)+1 new_point(2)];
                    for j = 1:point_vec
                        if check_right == point_vec(j,:) &&...
                                check_right(1) < MaxGridX && check_right(1) > 0 &&...
                                check_right(2) < MaxGridY && check_right(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                    check_down = [new_point(1) new_point(2)-1];
                    for j = 1:point_vec
                        if check_down == point_vec(j,:) &&...
                                check_down(1) < MaxGridX && check_down(1) > 0 &&...
                                check_down(2) < MaxGridY && check_down(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                    check_up = [new_point(1) new_point(2)+1];
                    for j = 1:point_vec
                        if check_up == point_vec(j,:) &&...
                                check_up(1) < MaxGridX && check_up(1) > 0 &&...
                                check_up(2) < MaxGridY && check_up(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                else
                    Viable = 0;
                end
            case 2
                Viable = 1;
                new_point = [point_vec(end,1) point_vec(end,2)-1];
                if new_point(1) < MaxGridX && new_point(1) > 0 &&...
                        new_point(2) < MaxGridY && new_point(2) > 0
                    check_left = [new_point(1)-1 new_point(2)];
                    for j = 1:point_vec
                        if check_left == point_vec(j,:) &&...
                                check_left(1) < MaxGridX && check_left(1) > 0 &&...
                                check_left(2) < MaxGridY && check_left(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                    check_down = [new_point(1) new_point(2)-1];
                    for j = 1:point_vec
                        if check_down == point_vec(j,:) &&...
                                check_down(1) < MaxGridX && check_down(1) > 0 &&...
                                check_down(2) < MaxGridY && check_down(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                    check_right = [new_point(1)+1 new_point(2)];
                    for j = 1:point_vec
                        if check_right == point_vec(j,:) &&...
                                check_right(1) < MaxGridX && check_right(1) > 0 &&...
                                check_right(2) < MaxGridY && check_right(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                else
                    Viable = 0;
                end
            case 3
                Viable = 1;
                new_point = [point_vec(end,1)-1 point_vec(end,2)];
                if new_point(1) < MaxGridX && new_point(1) > 0 &&...
                        new_point(2) < MaxGridY && new_point(2) > 0
                    check_left = [new_point(1)-1 new_point(2)];
                    for j = 1:point_vec
                        if check_left == point_vec(j,:) &&...
                                check_left(1) < MaxGridX && check_left(1) > 0 &&...
                                check_left(2) < MaxGridY && check_left(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                    check_down = [new_point(1) new_point(2)-1];
                    for j = 1:point_vec
                        if check_down == point_vec(j,:) &&...
                                check_down(1) < MaxGridX && check_down(1) > 0 &&...
                                check_down(2) < MaxGridY && check_down(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                    check_up = [new_point(1) new_point(2)+1];
                    for j = 1:point_vec
                        if check_up == point_vec(j,:) &&...
                                check_up(1) < MaxGridX && check_up(1) > 0 &&...
                                check_up(2) < MaxGridY && check_up(2) > 0
                            % New Point is corridor
                            Viable = 0;
                        end
                    end
                else
                    Viable = 0;
                end
        end
        if (Viable)
            point_vec(end+1,:) = new_point;
        end
    end
end

plot(point_vec(:,1),point_vec(:,2),'ok','MarkerFaceColor','k','MarkerSize',4)