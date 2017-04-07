function [figind] = visualize_dictionary(W,namestr)
%Input: 
%W       = the dictionary
%namestr = name of the image

%Output:
%figind = index of the figure in which the dictionary is visualized
%An image in jpg-format with name namestr

Wimg = W;
np   = sqrt(size(Wimg,1));
%Making W suitable for graphical presentation
Wimg=reshape(W,np,[]);
r=size(Wimg,2)/np;
Wimg=mat2cell(Wimg,[np],np*ones(1,r));
D=isqrt(r);
if(rem(r,D)==1)
    for i = 1:r
        D = D + 1;
        if(rem(r,D)==0)
            break;
        else
            continue;
        end
    end
end
Wimg=reshape(Wimg,D,[]);
maxW=1;

WIMG = figure;
for i=1:size(Wimg,1)
        for j=1:size(Wimg,2)
                subplot(size(Wimg,1),size(Wimg,2),j+(i-1)*size(Wimg,2))

                im=Wimg{i,j};
                %put the values of im into range [0,1]
                im=im-min(min(im));
                %maximum value of image
                maxim=max(max(im));
                %minimum value of image
                minim=min(min(im));
                %threshold for black, i.e. value of zero
                %MIN=0.3;
                MIN=minim;
                %threhold for whit, i.e. value of 1
                MAX=maxim;
                %gamma parameter
                gam=1.0;
                imagesc(im.^gam,[MIN MAX]);
                colormap(gray);
                axis image;
                axis off;
        end
end

saveas(WIMG,namestr,'jpg');

end
