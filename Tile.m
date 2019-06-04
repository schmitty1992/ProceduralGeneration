classdef Tile
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
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
            
            fill(obj.PolyX,obj.PolyY,'k')
            for i = 1:length(obj.WallVector)
                if ~isempty(obj.WallVector{i})
                    plot(obj.WallVector{i}(:,1),obj.WallVector{i}(:,2),'c','LineWidth',2)
                end
            end
            plot(obj.LocationCenter(1),obj.LocationCenter(2),'oc','MarkerFaceColor','w','MarkerSize',6)
            
        end
    end
end

