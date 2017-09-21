cam = webcam('Logitech HD Webcam C270');
preview(cam);

img = snapshot(cam);
figure, imshow(img);

