fileName = '600 & 300.wmv';
numFrames= 1;

obj = VideoReader(fileName);

for k = 1 : numFrames  
  this_frame = readFrame(obj);
  bwframe_orig = rgb2gray(this_frame);
  bwframe = logical(bwframe_orig);
  %bwframe = bwframe(50:480,:);
  
  n = size(bwframe);
  nrow = n(1);
  ncol = n(2);
  
  mask = ones(n);

%   seg = activecontour(bwframe,mask,240);
%   figure, imshow(seg)
%   title('Segmented image')
  
%   conn = bwconncomp(bwframe);
%   s = regionprops(conn,'Centroid');
%   centroids = cat(1, s.Centroid);
%   hold on
%   plot(centroids(:,1),centroids(:,2), 'r*')
%   hold off
  
  seg1 = bwareafilt(bwframe,1);
  seg2 = bwareafilt(bwframe,2) - seg1;
%   figure, imshow(seg1)
%   figure, imshow(seg2)

  pos1 = regionprops(seg1,'Centroid');
  pos2 = regionprops(seg2,'Centroid');
  
  obj1 = uint8(seg1).*bwframe_orig;
  obj2 = uint8(seg2).*bwframe_orig;
  figure, imshow(obj1)
  figure, imshow(obj2)
  id1 = getID(obj1)
  id2 = getID(obj2)
  
end
