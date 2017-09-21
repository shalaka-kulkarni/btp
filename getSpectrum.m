function [freq, sigfft] = getSpectrum(x_sig)

    win_L = 1;
    narr = size(x_sig);
    n = narr(1);
    padlen = 0;

    wn = hamming(win_L);
    %wvtool(wn)
    z1 = zeros(1,n-win_L);

    x_win = x_sig.*[wn' z1]';

    L = padlen + n;
    z = zeros(1,padlen);

    xp = [x_win' z];
    x_dft = fft(xp);
    w_k = (0:L-1) * (2*pi/L);

    sigfft  = abs(x_dft(1:(L-1)/2));
    freq = w_k(1:(L-1)/2);

end