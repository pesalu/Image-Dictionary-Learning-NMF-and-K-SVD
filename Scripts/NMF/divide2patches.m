function [V] = divide2patches(image,np)

%Input:
%image = image of size N x M pixels
%np    = number of pixels per edge of a square patch of the original image

%Output:
%V = matrix having in its columns the np x np -patches of the original image and V(i,j) in [0,1]

%Splitting vectors for mat2cell operation
splitvec1=(np*ones(1,size(image,1)/np));
splitvec2=(np*ones(1,size(image,2)/np));

%Split original picture into np x np patches
V=mat2cell(image,splitvec1,splitvec2);

%Number of np x np patches in each dimension fo original matrix v0
numpatch1 = size(V,1);
numpatch2 = size(V,2);

%Reshaped version of V
V = reshape(V,1,numpatch1*numpatch2);

%Dummy matrix
V2=zeros(np*np,numpatch1*numpatch2);
%
for i=1:numpatch1*numpatch2
  V2(:,i)=V{1,i}(:);
end

%Final original data matrix V
V=V2;

end
