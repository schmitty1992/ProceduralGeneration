clearvars
close all
clc

GridSizeX = 10;
GridSizeY = 10;

%- Direction Vectors
N = {[0 1]};
E = {[1 0]};
S = {[0 -1]};
W = {[-1 0]};
keySet = {0, 1, 2, 3};
valueSet = [N, E, S, W];
dir = containers.Map(keySet,valueSet);

figure
hold on
grid on

for i = 1:GridSizeX
    for j = 1:GridSizeY
        Map(i,j) = Tile;
        Map(i,j) = CreateCell(Map(i,j),i-0.5,j-0.5);
    end
end

for i = 1:GridSizeX
    for j = 1:GridSizeY
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
        switch direction
            case 0
                if (j+1 <= GridSizeY)
                    Map(i,j) = RemoveWall(Map(i,j),0);
                    Map(i,j+1) = RemoveWall(Map(i,j+1),2);
                    DisplayWall(Map(i,j+1))
                end
            case 1
                if (i+1 <= GridSizeX)
                    Map(i,j) = RemoveWall(Map(i,j),1);
                    Map(i+1,j) = RemoveWall(Map(i+1,j),3);
                    DisplayWall(Map(i+1,j))
                end
            case 2
                if (j-1 > 0)
                    Map(i,j) = RemoveWall(Map(i,j),2);
                    Map(i,j-1) = RemoveWall(Map(i,j-1),0);
                    DisplayWall(Map(i,j-1))
                end
            case 3
                if (i-1 > 0)
                    Map(i,j) = RemoveWall(Map(i,j),3);
                    Map(i-1,j) = RemoveWall(Map(i-1,j),1);
                    DisplayWall(Map(i-1,j))
                end
        end
        DisplayWall(Map(i,j))
    end
end

