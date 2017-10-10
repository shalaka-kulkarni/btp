fileName = '400 & 800.wmv';
numFrames= 1;

light1 = [0 0];
light2 = [10.3 1.1];
w = light1 - light2;
h = 22;
tx_max = 320/h;
ty_max = 240/h;

obj = VideoReader(fileName);
tic 
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

  c1 = regionprops(seg1,'Centroid'); 
  pos1 = c1.Centroid; x1 = pos1(1); y1 = pos1(2);
  c2 = regionprops(seg2,'Centroid'); 
  pos2 = c2.Centroid; x2 = pos2(1); y2 = pos2(2);
  
  obj1 = uint8(seg1).*bwframe_orig;
  obj2 = uint8(seg2).*bwframe_orig;
%   figure, imshow(obj1)
%   figure, imshow(obj2)
  id1 = getID(obj1)
  id2 = getID(obj2)
  
%   Ra = imref2d(size(bwframe_orig),xWorldLimits,yWorldLimits);
  imshow(bwframe_orig)
  hold on
  plot(x1, y1, 'b*')
  plot(x2, y2, 'r*')
  hold off
  
  tx1 = x1*tx_max/320; tx2 = x2*tx_max/320;
  ty1 = y1*ty_max/240; ty2 = y2*ty_max/240;
  u1 = tx1/sqrt(1+tx1^2+ty1^2);
  u2 = ty1/sqrt(1+tx1^2+ty1^2);
  u3 = 1/sqrt(1+tx1^2+ty1^2);
  v1 = tx2/sqrt(1+tx2^2+ty2^2);
  v2 = ty2/sqrt(1+tx2^2+ty2^2);
  v3 = 1/sqrt(1+tx2^2+ty2^2);
  vp = [v2 -v1]; u = [u1 u2];
  
  s_int = -(vp.*w)/(vp.*u);
  
  uv3 = [u u3];
  p_int = [light1 0] + s_int*uv3
  
  
  
%   [xWorld1, yWorld1] = intrinsicToWorld(Ra,pos1(1),pos1(2));
%   [xWorld2, yWorld2] = intrinsicToWorld(Ra,pos2(1),pos2(2));
  
end
toc
