function id = getID(bwframe)

  rowsum = sum(bwframe,2);
  t = (1:length(rowsum))';
  %plot(rowsum)
  order = 16;
  [p,s,mu] = polyfit(t,rowsum,order);
  f_y = polyval(p,t,[],mu);

  detrend_rowsum = rowsum - f_y;
  plot(detrend_rowsum)
  
  thresh = 0.1*max(abs(detrend_rowsum));
  sig1 = zeros(size(detrend_rowsum));
  for i=1:length(sig1)
     if abs(detrend_rowsum(i))>=thresh 
         sig1(i) = detrend_rowsum(i);
     end
  end
  %plot(rowsum)
  title('Original signal')
  %figure, plot(sig1)
  title('Detrended signal')
  
%   [freq, spectrum] = getSpectrum(sig1);
%   figure, plot(freq, spectrum)
%   title('Spectrum')
  
%   [pks, locs] = findpeaks(sig1);
%   diffsig = diff(locs);
%   meandiff = mean(diffsig);
%   id = meandiff;

  sz = size(sig1);
  L = sz(1);
  Fs = 19000; %T&E calibration. What's the actual Fs?
  
  spectrum = fft(sig1);
  P2 = abs(spectrum/L);
  P1 = P2(1:(L-1)/2+1);
  P1(2:end-1) = 2*P1(2:end-1);
  
  f = Fs*(0:(L-1)/2)/L;
  figure, plot(f,P1) 
  title('Spectrum')
  
  [maxval,maxind] = max(P1);
  freq_id = f(maxind);
  
  id = int8(freq_id/100);
  
end