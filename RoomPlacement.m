global MaxGridX;
global MaxGridY;

MinRoomSquareSize = 3;
MaxRoomSquareSize = 11;

NumPlacedRooms = 0;
MaxNumRooms = 8;

NumLargeRoomSize = 0;
MaxNumLargeRooms = 1;

StartRoomSize = [5 5];
BossRoomSize = [11 6];

RoomTypes = containers.Map({0,1,2,3},...
    {[244 220 181]/255,[79 121 66]/255,[211 211 211]/255, [255,223,0]/255});

while NumPlacedRooms < MaxNumRooms
    RestartFlag = 0;
    
    %- Pick Random Point on Grid for Center of XxY room
    if (NumPlacedRooms == 0)
        room_size_x = StartRoomSize(1);
        room_size_y = StartRoomSize(2);
    elseif (NumPlacedRooms == 1)
        room_size_x = BossRoomSize(1);
        room_size_y = BossRoomSize(2);
    else
        room_size_x = round(rand()*(MaxRoomSquareSize-MinRoomSquareSize))+MinRoomSquareSize;
        room_size_y = round(rand()*(MaxRoomSquareSize-MinRoomSquareSize))+MinRoomSquareSize;
    end
    if (mod(room_size_x,2) == 0)
        room_size_x = room_size_x + 1;
    end
    if (mod(room_size_y,2) == 0)
        room_size_y = room_size_y + 1;
    end
    
    rand_x = round(rand()*MaxGridX-2)+1;
    rand_y = round(rand()*MaxGridY-2)+1;
    
    minX = rand_x - (room_size_x-1)/2;
    maxX = rand_x + (room_size_x-1)/2;
    minY = rand_y - (room_size_y-1)/2;
    maxY = rand_y + (room_size_y-1)/2;
    
    %- Generate Perimeter Coords
    coord_x = [];
    coord_y = [];
    for i = 1:room_size_x
        coord_x(end+1) = minX + (i-1);
        coord_y(end+1) = minY;
    end
    for i = 2:room_size_y
        coord_x(end+1) = maxX;
        coord_y(end+1) = minY + (i-1);
    end
    for i = 2:room_size_x
        coord_x(end+1) = maxX - (i-1);
        coord_y(end+1) = maxY;
    end
    for i = 2:room_size_y
        coord_x(end+1) = minX;
        coord_y(end+1) = maxY - (i-1);
    end
    
    %- Redo if Coords are out of bounds
    if room_size_x * room_size_y > 49   
        if (NumLargeRoomSize > MaxNumLargeRooms)
            NumLargeRoomSize = NumLargeRoomSize - 1;
            RestartFlag = 1;
        else
            NumLargeRoomSize = NumLargeRoomSize + 1;
        end
    end
    if any(coord_x > MaxGridX) || any(coord_x < 0) ||...
            any(coord_y > MaxGridY) || any(coord_y < 0)
        RestartFlag = 1;
    end
    
    %- Check Points around placed room for previously placed rooms
    if (~RestartFlag)
        NumPlacedRooms = NumPlacedRooms + 1;
        RoomCoord(NumPlacedRooms).CenterX = rand_x;
        RoomCoord(NumPlacedRooms).CenterY = rand_y;
        RoomCoord(NumPlacedRooms).RoomSizeX = room_size_x;
        RoomCoord(NumPlacedRooms).RoomSizeY = room_size_y;
        RoomCoord(NumPlacedRooms).X_Vec = coord_x;
        RoomCoord(NumPlacedRooms).Y_Vec = coord_y;
        if NumPlacedRooms > 1
            for i = 1:NumPlacedRooms-1
                if any(ismember(RoomCoord(NumPlacedRooms).X_Vec,RoomCoord(i).X_Vec))
                    if any(ismember(RoomCoord(NumPlacedRooms).Y_Vec,RoomCoord(i).Y_Vec))
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

hold on
for i = 1:MaxNumRooms
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
    fill(RoomCoord(i).X_Vec,RoomCoord(i).Y_Vec,RoomTypes(room_type_selection))
    text(RoomCoord(i).CenterX-0.5,RoomCoord(i).CenterY,sprintf('%i',i),...
        'FontSize',16,'Color','w')
end


