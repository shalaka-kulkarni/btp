fileName = '900 & 300 (1).wmv';
numFrames= 1;

obj = VideoReader(fileName);

for k = 1 : numFrames  
  this_frame = readFrame(obj);
  bwframe = rgb2gray(this_frame);
  %BW1 = edge(bwframe,'sobel',0.4e-2);
  %imshowpair(bwframe, BW1,'montage');
  
  n = size(bwframe);
  nrow = n(1);
  ncol = n(2);
  
  bwframe1 = bwframe(40:nrow,1:ncol/2);
%   bwframe1 = bwframe(40:nrow,ncol/2:ncol);
  id = getID(bwframe1)
  
end