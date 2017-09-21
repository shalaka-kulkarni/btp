FileName = '900 & 300.wmv';
NumberOfFrames= 1;

obj = VideoReader(FileName);
for k = 1 : NumberOfFrames  %fill in the appropriate number
  this_frame = readFrame(obj);
  figure
  
  %title('Original');
  %sharp = imsharpen(this_frame,'Radius',30,'Amount',0.8);
  %figure, imshow(sharp)
  %title('Sharpened');
  bwframe = rgb2gray(this_frame);
  BW1 = edge(bwframe,'sobel',0.4e-2);
  imshowpair(bwframe, BW1,'montage')
  
  
end