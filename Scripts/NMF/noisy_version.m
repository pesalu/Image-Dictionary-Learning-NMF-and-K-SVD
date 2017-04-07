function [Vnoised] = noisy_version(V,noiselevel)

%Determine by noiseind -matrix, which pixels will be corrupted
noiseind=sprand(size(V,1),size(V,2),noiselevel);
noiseind(noiseind~=0.0)=1.0;
noiseind=logical(noiseind);

%finally add the noise with maximum amplitude maxV
maxV=max(max(V));
noisematrix=zeros(size(V,1),size(V,2));
noisematrix(noiseind)=maxV*rand(length(V(noiseind)),1);

if(noiselevel>0.0)
        V(noiseind)=maxV*rand(length(V(noiseind)),1);
end

V=V/max(max(V));

Vnoised=V;

end
