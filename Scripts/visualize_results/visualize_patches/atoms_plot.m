% Create image files showing the centroids in the dictionaries
%
% Samuli Siltanen April 2015

% Parameters for controlling the appearance of plots
gammacorr = 1;

% Load pepper dictionary
%load Peppers1_8x8 k CN dictionary clusterind
load Peppers1_8x8 k CN dictionary clusterind

MIN = min(dictionary(:));
MAX = max(dictionary(:));

for iii = 1:size(dictionary,2);
    
    % Save the atom image to file
    M     = 20;
    atom  = reshape(dictionary(:,iii),k,k);
    atom  = atom-MIN;
    atom  = atom/(MAX-MIN);
    atom  = atom.^gammacorr;
    atomM = zeros(M*k,M*k);
    for row = 1:k
        for col = 1:k
            atomM((row-1)*M+[1:M],(col-1)*M+[1:M]) = atom(row,col);
        end
    end
    filename = ['images/Peppers1_8x8_atom_',num2str(iii,'%03d'),'.png'];
    imwrite(uint8(255*atomM),filename,'png')
    
end

% Load pepper dictionary
load Peppers1_12x12 k CN dictionary clusterind
MIN = min(dictionary(:));
MAX = max(dictionary(:));

for iii = 1:size(dictionary,2);
    
    % Save the atom image to file
    M     = 20;
    atom  = reshape(dictionary(:,iii),k,k);
    atom  = atom-MIN;
    atom  = atom/(MAX-MIN);
    atom  = atom.^gammacorr;
    atomM = zeros(M*k,M*k);
    for row = 1:k
        for col = 1:k
            atomM((row-1)*M+[1:M],(col-1)*M+[1:M]) = atom(row,col);
        end
    end
    filename = ['images/Peppers1_12x12_atom_',num2str(iii,'%03d'),'.png'];
    imwrite(uint8(255*atomM),filename,'png')
    
end


% Load match dictionary
load Matches1_8x8 k CN dictionary clusterind
MIN = min(dictionary(:));
MAX = max(dictionary(:));

for iii = 1:size(dictionary,2);
    
    % Save the atom image to file
    M     = 20;
    atom  = reshape(dictionary(:,iii),k,k);
    atom  = atom-MIN;
    atom  = atom/(MAX-MIN);
    atom  = atom.^gammacorr;
    atomM = zeros(M*k,M*k);
    for row = 1:k
        for col = 1:k
            atomM((row-1)*M+[1:M],(col-1)*M+[1:M]) = atom(row,col);
        end
    end
    filename = ['images/Matches1_8x8_atom_',num2str(iii,'%03d'),'.png'];
    imwrite(uint8(255*atomM),filename,'png')
    
end


% Load match dictionary
load Matches1_12x12 k CN dictionary clusterind
MIN = min(dictionary(:));
MAX = max(dictionary(:));

for iii = 1:size(dictionary,2);
    
    % Save the atom image to file
    M     = 20;
    atom  = reshape(dictionary(:,iii),k,k);
    atom  = atom-MIN;
    atom  = atom/(MAX-MIN);
    atom  = atom.^gammacorr;
    atomM = zeros(M*k,M*k);
    for row = 1:k
        for col = 1:k
            atomM((row-1)*M+[1:M],(col-1)*M+[1:M]) = atom(row,col);
        end
    end
    filename = ['images/Matches1_12x12_atom_',num2str(iii,'%03d'),'.png'];
    imwrite(uint8(255*atomM),filename,'png')
    
end
