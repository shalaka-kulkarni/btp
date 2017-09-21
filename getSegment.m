fileName = '900 & 300 (1).wmv';
numFrames= 1;

obj = VideoReader(fileName);

this_frame = readFrame(obj);
bwframe = rgb2gray(this_frame);
bwframe = bwframe(50:480,:);
imshow(bwframe)
title('Original image')
 
n = size(bwframe);
mask = ones(n);

seg = activecontour(bwframe,mask,240);
figure, imshow(seg)
title('Segmented image')

s = regionprops(seg,'centroid');
centroids = cat(1, s.Centroid);
hold on
plot(centroids(:,1),centroids(:,2), 'r*')
hold off