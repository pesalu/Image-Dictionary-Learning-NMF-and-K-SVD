function [Ns] = make_noise_sample(maxval,noiselevel,dim1,dim2)

% Inputs:
%dim1,dim2 = dimensions of the 2d noise sample

% Output:
% Ns = noise sample of size dim1 x dim2

%Determine by noiseind -matrix, which pixels will be corrupted
noiseind=sprand(dim1,dim2,noiselevel);
noiseind(noiseind~=0.0)=1.0;
noiseind=logical(noiseind);

Ns    = zeros(dim1,dim2);
numel = length(Ns(noiseind));
Ns(noiseind) = maxval*rand(numel,1);

end
