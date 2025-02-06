# Hand Gesture-Based Zoom-In and Zoom-Out using Webcam

## Overview
This project implements a MATLAB-based hand gesture recognition system to perform zoom-in and zoom-out operations on an image using a webcam. The system captures a real-time video feed, processes the gesture input, detects the number of fingers shown, and adjusts the zoom level accordingly.

## Features
- Uses a webcam to detect hand gestures.
- Background subtraction and image preprocessing for accurate gesture recognition.
- Detects the number of fingers raised to control zooming.
- Dynamically adjusts zoom levels between 1x and 3x.
- Displays the original gesture, processed image, and zoomed image in a multi-panel layout.

## Installation
### Prerequisites
- MATLAB (with Image Processing Toolbox)
- Webcam


## How It Works
1. The script initializes the webcam and captures an initial background frame.
2. A selected image is loaded for zooming operations.
3. Real-time video feed is processed:
   - Background subtraction
   - Grayscale conversion & binarization
   - Noise reduction & morphological operations
4. The number of fingers is detected based on contour peaks.
5. Zoom levels are adjusted dynamically:
   - Increase zoom when finger count increases.
   - Decrease zoom when finger count decreases.
6. The processed images and zoomed view are displayed in a multi-panel figure.



## Troubleshooting
- Ensure the webcam is properly connected and accessible via MATLAB.
- Adjust image preprocessing parameters if gesture recognition is inaccurate.
- Use a well-lit environment to improve hand gesture detection.

## License
This project is licensed under the MIT License.

## Author
[Yagnesh Hirpara](https://github.com/YagneshHirpara)

