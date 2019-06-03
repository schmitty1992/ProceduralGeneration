classdef Tile
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        LocationCenter = [0 0];
        LocationEdges = [0 0;
            0 0;
            0 0;
            0 0;
            0 0];
        Walls = 0; % Binary 0000 each bit represents a wall
        % 0 - Wall
        % 1 - No Wall
    end
    
    methods
        function obj = CreateCell(obj,CenterX,CenterY)
            obj.LocationCenter = [CenterX, CenterY];
            obj.LocationEdges = [CenterX-0.5 CenterY-0.5;
                CenterX+0.5 CenterY-0.5;
                CenterX+0.5 CenterY+0.5;
                CenterX-0.5 CenterY+0.5;
                CenterX-0.5 CenterY-0.5];
        end
        function obj = RemoveWall(obj,direction)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Walls = bitor(obj.Walls,direction);
            switch direction
                case 1 % North
                    obj.LocationEdges = obj.LocationEdges
                case 2 % East
                case 4 % South
                case 8 % West
            end
        end
        
        function DisplayWall(obj)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            fill(obj.LocationEdges(1,:),obj.LocationEdges(2,:),'k')
            plot(obj.LocationCenter(1),obj.LocationCenter(2),'oc','MarkerFaceColor','w','MarkerSize',2)
            plot(obj.LocationEdges(1,:),obj.LocationEdges(2,:),'c','LineWidth',2)
        end
    end
end

