function []=contrast()
% Adjust a monochrome image to look better.
%
% Samuli Siltanen May 2014

% Read in the image. The second line converts the image into floating point
% numbers (instead of "uint8" integer values)
im = imread('Wrec.jpg','jpg');
im = rgb2gray(im);
%im = imread('orig.png','png');
im=double(im);

% Create plot window
figure(1)
clf

% Show the image without adjustment
imagesc(im)
axis equal
axis off
colormap gray

% Normalize the image in the interval [0,1]
im = im-min(im(:)); % Adjust minimum pixel value to be zero
im = im/max(im(:)); % Adjust maximum pixel value to be one

% Choose graylevel cutoffs 
%MIN = 0.33; % Use values greater than zero to ensure black pixels
MIN = 0.4;
%MAX = 0.8; % Use values smaller than one to ensure white pixels
MAX = 0.7;

% Gamma correction parameter
gam = .8; 
%gam=0.2
% Create plot window
figure(2)
clf

% Show the image
imagesc(im.^gam,[MIN,MAX])
axis equal
axis off
colormap gray


end
