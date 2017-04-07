function [Vimg] = back2image(V)

%Input:
%V = the patched version of the original SQUARE N x N image 
%(e.g. if np = 8, then size of V is np^2 x (N/8)^2 -matrix)
% 
%Output:
%Vimg = original N x N image corresponding matrix V



%Get dimensions
[dim1 dim2] = size(V);

%Number of pixels per edge of the square np x np -patch
np = sqrt(size(V,1));

%
if( (sqrt(dim1)-ceil(sqrt(dim1))) ~= 0)
        fprintf('The input matrix is not in square patched form! \n');
        return;
end

%
V     = reshape(V,np,[]);
Vcell = mat2cell(V,np,np*ones(1,dim2));

%Number of patches (np x np) per dimension 
numpatch1 = sqrt(dim2);
numpatch2 = numpatch1;

if(numpatch1 - ceil(numpatch1) ~= 0)
	fprintf('The original image is not square! \n');
	return;
else
	Vcell=reshape(Vcell,numpatch1,numpatch2);
	Vimg=cell2mat(Vcell);
end

end
