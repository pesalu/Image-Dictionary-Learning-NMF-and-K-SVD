function [figind] = visualize_image(V,namestr)
%Input:
%V       = square N x N image in patched form
%namestr = name of the image
%Output
%figind = figure index
%Image of the given image (e.g. reconstruction WH) in jpg-format with
%name namestr


% Number of pixels per dimension in a square patch of image
% image V
np       = sqrt(size(V,1));
%Total number of patches in V
numpatch = size(V,2);
%Reshape V
V=reshape(V,np,[]);
V=reshape(V,np,[]);
V=mat2cell(V,[np],np*ones(1,numpatch));
V=reshape(V,sqrt(numpatch),sqrt(numpatch));
Vimg=cell2mat(V);

VIMG=figure(1);
clf
imagesc(Vimg);
colormap(gray);
%colorbar;
axis off;
axis image;
set(gca,'fontsize',8);
%title('V');
tightPos=get(gca,'TightInset');
noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
  tightPos(3:4))];
set(gca,'Position',noDeadSpacePos);
saveas(VIMG,namestr,'jpg');

end
