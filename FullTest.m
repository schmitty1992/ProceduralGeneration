err = MException('','');
for i = 1:10
    try
        MazeGeneration;
        disp('Success')
    catch e
        err(end+1) = e;
    end
end