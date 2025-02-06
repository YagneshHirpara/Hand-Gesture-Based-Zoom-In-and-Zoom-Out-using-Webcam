% Hand Gesture-Based Zoom-In and Zoom-Out using Webcam

clear all; clc; close all; % Clear variables, command windows, close any open windows

% Initialize video input from webcam
cam = webcam; % Access webcam device
figure(1);


img = imread("/MATLAB Drive/image processing/333.jpg"); % Load the selected image
zoomFactor = 1; % Initialize zoom factor
prevFingerCount = 0; % Initialize previous finger count

% Capture initial background image
backgroundFrame = snapshot(cam); % Background snapshot
subplot(3, 3, 1); imshow(backgroundFrame); title('Background');

% Zoom Logic Based on Finger Count
while ishandle(1) % Loop as long as the figure window is open
    % Capture the current frame
    currentFrame = snapshot(cam); % Gesture snapshot
    subplot(3, 3, 2); imshow(currentFrame); title('Gesture');

    % Subtract Background
    diffFrame = imsubtract(backgroundFrame, currentFrame); % Subtract background
    diffFrame = rgb2gray(diffFrame); % Convert to grayscale
    lvl = graythresh(diffFrame); % Find threshold for binary conversion
    binaryFrame = imbinarize(diffFrame, lvl); % Convert to binary (black & white)
    binaryFrame = bwareaopen(binaryFrame, 10000); % Remove small objects
    binaryFrame = imfill(binaryFrame, 'holes'); % Fill holes
    binaryFrame = imerode(binaryFrame, strel('disk', 15)); % Erode
    binaryFrame = imdilate(binaryFrame, strel('disk', 20)); % Dilate
    binaryFrame = medfilt2(binaryFrame, [5 5]); % Apply median filter
    binaryFrame = flipdim(binaryFrame, 1); % Flip image rows

    % Display processed binary image
    subplot(3, 3, 3); imshow(binaryFrame); title('Processed Gesture');

    % Calculate properties of the detected regions
    regions = regionprops(binaryFrame, 'all');
    CEN = cat(1, regions.Centroid); % Find centroids
    [boundaries, ~, ~, ~] = bwboundaries(binaryFrame, 'noholes'); % Get boundary data

    fingerCount = 0; % Initialize finger count

    % For each detected object, find the number of peaks (fingers)
    for k = 1:length(boundaries)
        boundary = boundaries{k}; % Get boundary of the region
        boundaryY = boundary(:, 1); % Get Y-coordinates of boundary

        % Detect Peaks (Fingers) above a certain height threshold
        pkoffset = CEN(:, 2) + 0.5 * (CEN(:, 2)); % Peak offset from centroid
        [pks, ~] = findpeaks(boundaryY, 'minpeakheight', pkoffset); % Detect peaks
        fingerCount = size(pks, 1); % Update finger count based on peaks
    end

    % Adjust Zoom Factor Based on Finger Count Transition
    if fingerCount >= 3 && fingerCount <= 5 && fingerCount > prevFingerCount
        zoomFactor = min(zoomFactor + 0.1, 3); % Zoom in, max zoom factor of 3
    elseif fingerCount <= 5 && fingerCount >= 3 && fingerCount < prevFingerCount
        zoomFactor = max(zoomFactor - 0.1, 1); % Zoom out, min zoom factor of 1
    end
    
    % Update previous finger count
    prevFingerCount = fingerCount;

    % Display the selected image with the current zoom factor
    subplot(3, 3, 4); imshow(imresize(img, zoomFactor)); title(['Zoom Factor: ', num2str(zoomFactor)]);

    % Display finger count on processed image
    text(10, 10, ['Fingers: ', num2str(fingerCount)], 'Color', 'r', 'FontSize', 14);

    pause(0.1); % Short pause for stability
end

% Clean up
clear cam;
