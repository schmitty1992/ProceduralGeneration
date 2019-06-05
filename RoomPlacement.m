global MaxGridX;
global MaxGridY;

MinRoomSquareSize = 3;
MaxRoomSquareSize = 6;

NumPlacedRooms = 0;
MaxNumRooms = 8;

NumLargeRoomSize = 0;
MaxNumLargeRooms = 1;

StartRoomSize = [3 3];
BossRoomSize = [10 6];

while NumPlacedRooms < MaxNumRooms
%     fprintf('# Placed Rooms: %i \n',NumPlacedRooms)
    RestartFlag = 0;
    
    %- Pick Random Point on Grid for Center of XxY room
    if (NumPlacedRooms == 0)
        room_size_x = StartRoomSize(1);
        room_size_y = StartRoomSize(2);
    elseif (NumPlacedRooms == 1)
        room_size_x = BossRoomSize(1);
        room_size_y = BossRoomSize(2);
    else
        room_size_x = randi([MinRoomSquareSize,MaxRoomSquareSize]);
        room_size_y = randi([MinRoomSquareSize,MaxRoomSquareSize]);
    end
    if (mod(room_size_x,2) == 0)
        room_size_x = room_size_x + 1;
    end
    if (mod(room_size_y,2) == 0)
        room_size_y = room_size_y + 1;
    end
    
    if NumPlacedRooms == 0
        rand_x = StartX-0.5;
        rand_y = StartY-0.5;
    elseif NumPlacedRooms == 1
        rand_x = EndX-0.5;
        rand_y = EndY-0.5;
    else
        rand_x = randi([0,MaxGridX-2]);
        rand_y = randi([0,MaxGridY-2]);
    end
    
    minX = rand_x - (room_size_x-1)/2;
    maxX = rand_x + (room_size_x-1)/2;
    minY = rand_y - (room_size_y-1)/2;
    maxY = rand_y + (room_size_y-1)/2;
    
    %- Generate Perimeter Coords
    perimeter_x = [];
    perimeter_gap_x = [];
    perimeter_y = [];
    perimeter_gap_y = [];
    for i = 1:room_size_x
        perimeter_x(end+1) = minX + (i-1);
        perimeter_y(end+1) = minY;
        perimeter_gap_x(end+1) = (minX-1) + (i-1);
        perimeter_gap_y(end+1) = minY-1;
    end
    for i = 1:2
        perimeter_gap_x(end+1) = perimeter_gap_x(end) + 1;
        perimeter_gap_y(end+1) = minY-1;
    end
    for i = 2:room_size_y
        perimeter_x(end+1) = maxX;
        perimeter_y(end+1) = minY + (i-1);
        perimeter_gap_x(end+1) = maxX+1;
        perimeter_gap_y(end+1) = (minY-1) + (i-1);
    end
    for i = 1:2
        perimeter_gap_x(end+1) = maxX+1;
        perimeter_gap_y(end+1) = perimeter_gap_y(end) + 1;
    end
    for i = 2:room_size_x
        perimeter_x(end+1) = maxX - (i-1);
        perimeter_y(end+1) = maxY;
        perimeter_gap_x(end+1) = (maxX+1) - (i-1);
        perimeter_gap_y(end+1) = maxY+1;
    end
    for i = 1:2
        perimeter_gap_x(end+1) = perimeter_gap_x(end) - 1;
        perimeter_gap_y(end+1) = maxY+1;
    end
    for i = 2:room_size_y
        perimeter_x(end+1) = minX;
        perimeter_y(end+1) = maxY - (i-1);
        perimeter_gap_x(end+1) = minX-1;
        perimeter_gap_y(end+1) = (maxY+1) - (i-1);
    end
    for i = 1:2
        perimeter_gap_x(end+1) = minX-1;
        perimeter_gap_y(end+1) = perimeter_gap_y(end) - 1;
    end
    
    %- Redo if Number of Larges Rooms has been reached
    if room_size_x * room_size_y > 49   
        if (NumLargeRoomSize > MaxNumLargeRooms)
            NumLargeRoomSize = NumLargeRoomSize - 1;
            RestartFlag = 1;
        else
            NumLargeRoomSize = NumLargeRoomSize + 1;
        end
    end
    
    %- Redo if Perimeter are out of bounds
    if any(perimeter_x > MaxGridX) || any(perimeter_x < 0) ||...
            any(perimeter_y > MaxGridY) || any(perimeter_y < 0)
        RestartFlag = 1;
    end
    
    %- Check Points around placed room for previously placed rooms
    if (~RestartFlag)
        NumPlacedRooms = NumPlacedRooms + 1;
        RoomCoord(NumPlacedRooms).CenterX = rand_x;
        RoomCoord(NumPlacedRooms).CenterY = rand_y;
        RoomCoord(NumPlacedRooms).RoomSizeX = room_size_x;
        RoomCoord(NumPlacedRooms).RoomSizeY = room_size_y;
        RoomCoord(NumPlacedRooms).X_Vec = perimeter_x;
        RoomCoord(NumPlacedRooms).Y_Vec = perimeter_y;
        RoomCoord(NumPlacedRooms).X_Gap_Vec = perimeter_gap_x;
        RoomCoord(NumPlacedRooms).Y_Gap_Vec = perimeter_gap_y;
        if NumPlacedRooms > 1
            for i = 1:NumPlacedRooms-1
                if any(ismember(RoomCoord(NumPlacedRooms).X_Gap_Vec,RoomCoord(i).X_Gap_Vec))
                    if any(ismember(RoomCoord(NumPlacedRooms).Y_Gap_Vec,RoomCoord(i).Y_Gap_Vec))
                        % Not Valid Placement Location
                        NumPlacedRooms = NumPlacedRooms - 1;
                        RoomCoord = RoomCoord(1:NumPlacedRooms);
                        if room_size_x * room_size_y > 35
                            NumLargeRoomSize = NumLargeRoomSize - 1;
                        end
                    end
                end
            end
        end
    end
end


% Find Bottom Left Corner and Top Right Corner of Room
% Change each cell in area to room type (no walls for now)
hold on
for room = 1:length(RoomCoord)
    if room == 1
        room_type_selection = 5;
    elseif room == 2
        room_type_selection = 4;
    else
        percent_chance = rand();
        if (percent_chance < 0.05)
            room_type_selection = 3;
        elseif (percent_chance < 0.30)
            room_type_selection = 0;
        elseif (percent_chance < 0.60)
            room_type_selection = 1;
        elseif (percent_chance <= 1)
            room_type_selection = 2;
        end
    end
    for i = RoomCoord(room).X_Vec(1)+1:RoomCoord(room).X_Vec(RoomCoord(room).RoomSizeX)+1
        for j = RoomCoord(room).Y_Vec(1)+1:RoomCoord(room).Y_Vec(end-RoomCoord(room).RoomSizeY)+1
            if (AnimateDraw)
                pause(1e-2)
            end
            if (i == RoomCoord(room).X_Vec(1))
                Map(i,j) = ChangeToRoom(Map(i,j),room_type_selection,true,4);
            elseif (i == RoomCoord(room).X_Vec(end))
                Map(i,j) = ChangeToRoom(Map(i,j),room_type_selection,true,2);
            elseif (j == RoomCoord(room).Y_Vec(1))
                Map(i,j) = ChangeToRoom(Map(i,j),room_type_selection,true,1);
            elseif (j == RoomCoord(room).Y_Vec(end))
                Map(i,j) = ChangeToRoom(Map(i,j),room_type_selection,true,3);
            else
                Map(i,j) = ChangeToRoom(Map(i,j),room_type_selection,true,5);
            end
        end
    end
end

%         RoomTypes = containers.Map({0,1,2,3,4,5},...
%             {[244 220 181]/255,...
%             [79 121 66]/255,...
%             [211 211 211]/255,...
%             [255,223,0]/255,...
%             [155 17 30]/255,...
%             [51 165 50]/255});
% for i = 1:MaxNumRooms
%     if i == 1
%         room_type_selection = 5;
%     elseif i == 2
%         room_type_selection = 4;
%     else
%         percent_chance = rand();
%         if (percent_chance < 0.05)
%             room_type_selection = 3;
%         elseif (percent_chance < 0.30)
%             room_type_selection = 0;
%         elseif (percent_chance < 0.60)
%             room_type_selection = 1;
%         elseif (percent_chance <= 1)
%             room_type_selection = 2;
%         end
%     end
%     fill(RoomCoord(i).X_Vec,RoomCoord(i).Y_Vec,RoomTypes(room_type_selection))
%     text(RoomCoord(i).CenterX-0.5,RoomCoord(i).CenterY,sprintf('%i',i),...
%         'FontSize',16,'Color','w')
% end
% 
% 
