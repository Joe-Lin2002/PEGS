% Video Frames Export
% frame_export, Junyi Lin, Jun12 2023, Version 1
% Note: This code is assisted by ChatGPT, a product of OpenAI

% Input parameters
directory = 'DATA/large_container_static/';
files = dir([directory, 'DSC_0014.MOV']); %File Locating
timeStart = 14; % Start time of the time span (in seconds)
timeEnd = 15; % End time of the time span (in seconds)
numFrames = 1; % Number of frames to export

% Create a VideoReader object
videoReader = VideoReader([directory,files(1).name]);

% Calculate the frame rate and total number of frames
frameRate = videoReader.FrameRate;
totalFrames = videoReader.NumFrames;

% Convert time span to frame numbers
startFrame = round(timeStart * frameRate);
endFrame = round(timeEnd * frameRate);
framesToExport = linspace(startFrame, endFrame, numFrames);

% Read and save the selected frames
for i = 1:numFrames
    frameNumber = round(framesToExport(i));
    
    % Check if the frame number is within the valid range
    if frameNumber >= 1 && frameNumber <= totalFrames
        videoReader.CurrentTime = frameNumber / frameRate;
        frame = readFrame(videoReader);
        
        % Construct the output file path
        outputFileName = fullfile(directory, sprintf('frame_%d.jpg', frameNumber));
        
        % Save the frame as a .jpg image
        imwrite(frame, outputFileName);
        
        % Display confirmation message
        fprintf('Frame %d saved as %s.\n', frameNumber, outputFileName);
    else
        fprintf('Frame number %d is out of range.\n', frameNumber);
    end
end
