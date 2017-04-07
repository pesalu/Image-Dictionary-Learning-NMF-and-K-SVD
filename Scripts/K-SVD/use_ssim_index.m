function [sim]=use_ssim_index(A,B)

%Force to double precision
A=double(A);
B=double(B);

%Put values to [0,1] range
A=A/max(max(A));
B=B/max(max(B));

%Convert to 8-bit form
A=uint8(100*A);
B=uint8(100*B);

sim=ssim_index(A,B)

end
