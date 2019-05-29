classdef Tile
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        LocationCenter = {[0 0]};
        LocationEdges = {[0 0 0 0; 0 0 0 0]};
        Walls = 0; % Binary 1111 each bit represents a wall
    end
    
    methods
        function obj = RemoveWall(obj,direction)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
%             obj.Walls = bitor(obj.Walls,direction);
            obj.Walls = obj.Walls + 2;
        end
        
        function DisplayWall(obj)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            fprintf('Walls: %i \n',obj.Walls)
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

