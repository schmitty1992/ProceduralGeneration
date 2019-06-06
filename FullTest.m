clc
for i = 1:10
    disp('===================')
    try
        MazeGeneration;
        disp('Success')
    catch e
        disp(e)
    end
    fprintf('Seed: %i \n',Seed)
    disp('===================')
end