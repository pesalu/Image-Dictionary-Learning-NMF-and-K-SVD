function [figind] = visualize_image(V,namestr)
%Input:
%V = image to be visualized
%namestr = name of the image
%Output
%figind = figure index
%Image of the given image (e.g. reconstruction WH) in jpg-format with
%name namestr

VIMG=figure(1);
clf
imagesc(V);
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
