classdef Tile
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %- Room Types
        % 0 - Sand
        % 1 - Forest
        % 2 - Cave
        % 3 - Treasure
        RoomTypes = containers.Map({0,1,2,3,4,5},...
            {[244 220 181]/255,...
            [79 121 66]/255,...
            [211 211 211]/255,...
            [255,223,0]/255,...
            [155 17 30]/255,...
            [51 165 50]/255});
        
        LocationCenter = [0 0];
        WallVector = [{[0 0; 0 0]};
            {[0 0; 0 0]};
            {[0 0; 0 0]};
            {[0 0; 0 0]}];
        Walls = 0; % Binary 0000 each bit represents a wall
        % 0 - Wall
        % 1 - No Wall
        PolyX = [];
        PolyY = [];
        Visited = false;
        isStartPoint = false;
        isRoom = false;
        RoomType = [];
        isPerimeter = false;
    end
    
    methods
        function obj = CreateCell(obj,CenterX,CenterY)
            obj.LocationCenter = [CenterX, CenterY];
            obj.WallVector{1} = [CenterX-0.5 CenterY-0.5; CenterX+0.5 CenterY-0.5];
            obj.WallVector{2} = [CenterX+0.5 CenterY-0.5; CenterX+0.5 CenterY+0.5];
            obj.WallVector{3} = [CenterX+0.5 CenterY+0.5; CenterX-0.5 CenterY+0.5];
            obj.WallVector{4} = [CenterX-0.5 CenterY+0.5; CenterX-0.5 CenterY-0.5];
            
            for i = 1:length(obj.WallVector)
                obj.PolyX(end+1) = obj.WallVector{i}(1,1);
                obj.PolyY(end+1) = obj.WallVector{i}(1,2);
            end
        end
        
        function obj = RemoveWall(obj,direction)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Walls = bitor(obj.Walls,direction);
            switch direction
                case 0 % North
                    obj.WallVector{3} = [];
                case 1 % East
                    obj.WallVector{2} = [];
                case 2 % South
                    obj.WallVector{1} = [];
                case 3 % West
                    obj.WallVector{4} = [];
            end
        end
        
        function DisplayWall(obj)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            if (obj.isRoom)
                fill(obj.PolyX,obj.PolyY,obj.RoomTypes(obj.RoomType),...
                    'EdgeColor',obj.RoomTypes(obj.RoomType)); 
            elseif obj.isStartPoint
                fill(obj.PolyX,obj.PolyY,'g','EdgeColor','g')
            elseif obj.Visited
                fill(obj.PolyX,obj.PolyY,[150 150 150]/255,...
                    'EdgeColor',[150 150 150]/255)
            else
                fill(obj.PolyX,obj.PolyY,'k')
            end
            if (~obj.isPerimeter)
                for i = 1:length(obj.WallVector)
                    if ~isempty(obj.WallVector{i})
                        plot(obj.WallVector{i}(:,1),obj.WallVector{i}(:,2),'c','LineWidth',2)
                    end
                end
            end
        end
        
        function obj = ChangeToRoom(obj,RoomType,isPerimeter)
            obj.isPerimeter = isPerimeter;
            obj.RoomType = RoomType;
            obj.isRoom = true;
            DisplayWall(obj)
        end
    end
end

