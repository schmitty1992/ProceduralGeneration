clearvars
close all
clc

GridSizeX = 20;
GridSizeY = 20;

% Map = zeros(GridSizeX,GridSizeY);

figure
hold on
grid on

for i = 1:GridSizeX
    for j = 1:GridSizeY
        Map(i,j) = Tile;
        Map(i,j) = CreateCell(Map(i,j),i-0.5,j-0.5);
        DisplayWall(Map(i,j))
    end
end