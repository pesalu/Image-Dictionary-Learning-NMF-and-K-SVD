% Create latex files showing the centroids in the dictionaries.
% We assume here that the number of atoms is a square.
%
% Samuli Siltanen April 2015

% Set displacement and image size to be used in the latex code
dsplcm = 20;
imsize = .6;
top    = 200;

% Load pepper dictionary
load Peppers1_8x8 k CN dictionary clusterind
K = sqrt(size(dictionary,2));
if (K-floor(K))>0
    error('The number of atoms must be square')
end

% Open a text file
fid = fopen('Peppers1_8x8.tex','w');
% Loop over atoms
for iii = 1:K;
    for jjj = 1:K;
        imind = (jjj-1)*K+iii;
        x = (jjj-1)*dsplcm;
        y = top-(iii-1)*dsplcm;
        fprintf(fid,'\\put(%6.1f ,%6.1f ){\\includegraphics[width=%6.2f cm]{images/Peppers1_8x8_atom_%03d}}\n',x,y,imsize,imind);
    end
end
% Close the text file
fclose(fid);

% Load pepper dictionary
load Peppers1_8x8 k CN dictionary clusterind
K = sqrt(size(dictionary,2));
if (K-floor(K))>0
    error('The number of atoms must be square')
end

% Open a text file
fid = fopen('Peppers1_12x12.tex','w');
% Loop over atoms
for iii = 1:K;
    for jjj = 1:K;
        imind = (jjj-1)*K+iii;
        x = (jjj-1)*dsplcm;
        y = top-(iii-1)*dsplcm;
        fprintf(fid,'\\put(%6.1f ,%6.1f ){\\includegraphics[width=%6.2f cm]{images/Peppers1_12x12_atom_%03d}}\n',x,y,imsize,imind);
    end
end
% Close the text file
fclose(fid);

% Load match dictionary
load Matches1_8x8 k CN dictionary clusterind
K = sqrt(size(dictionary,2));
if (K-floor(K))>0
    error('The number of atoms must be square')
end

% Open a text file
fid = fopen('Matches1_8x8.tex','w');
% Loop over atoms
for iii = 1:K;
    for jjj = 1:K;
        imind = (jjj-1)*K+iii;
        x = (jjj-1)*dsplcm;
        y = top-(iii-1)*dsplcm;
        fprintf(fid,'\\put(%6.1f ,%6.1f ){\\includegraphics[width=%6.2f cm]{images/Matches1_8x8_atom_%03d}}\n',x,y,imsize,imind);
    end
end
% Close the text file
fclose(fid);


% Load match dictionary
load Matches1_12x12 k CN dictionary clusterind
K = sqrt(size(dictionary,2));
if (K-floor(K))>0
    error('The number of atoms must be square')
end

% Open a text file
fid = fopen('Matches1_12x12.tex','w');
% Loop over atoms
for iii = 1:K;
    for jjj = 1:K;
        imind = (jjj-1)*K+iii;
        x = (jjj-1)*dsplcm;
        y = top-(iii-1)*dsplcm;
        fprintf(fid,'\\put(%6.1f ,%6.1f ){\\includegraphics[width=%6.2f cm]{images/Matches1_12x12_atom_%03d}}\n',x,y,imsize,imind);
    end
end
% Close the text file
fclose(fid);