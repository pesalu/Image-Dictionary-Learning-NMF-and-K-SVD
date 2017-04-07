%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot ||V-WH|| vs. number of iterations
% in learning phase
%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Load data 1 \n');
load data/dictionaryNMFdata.mat diff
diffNMF = diff(:,2);

fprintf('Load data 2 \n');
load data/dictionaryKSVDdata.mat diff
diffKSVD = diff;

figure(1);
clf;
hold
plot(diffNMF,'r*-','linewidth',7);
plot(diffKSVD,'bo-','linewidth',7);
grid on;
xlabel('Number of iterations','FontSize',15,'FontWeight','bold');
ylabel('Difference ||.||_F','FontSize',15,'FontWeight','bold');
set(gca,'fontsize',20);
legend('NMF','K-SVD');
str = sprintf('learning_curve_BB_ksvd');
print('-depsc',str);
hold


%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot reconstruction errors in terms of Frob. norm and SSIM index.
% Plot sparsity(H)
% in Step 1
%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Load data 3 \n');
load data/reconstruct_NMFdata.mat diffvec Hs WHimgs
diffNMF1     = diffvec;
WHimgsNMFrec = WHimgs;
HsNMF        = Hs;

fprintf('Load data 4 \n');
load data/reconstruct_OMPdata.mat diffvec Hs WHimgs
diffOMP1      = diffvec;
WHimgsKSVDrec = WHimgs;
HsKSVD        = Hs;

figure(1);
clf;
hold
plot(100*diffNMF1(:,1),diffNMF1(:,2),'r*-','linewidth',7);
plot(100*diffOMP1(:,1),diffOMP1(:,2),'bo-','linewidth',7);
plot(100*diffNMF1(:,1),diffNMF1(:,4),'m--','linewidth',7);
grid on;
xlabel('Noise level (%)','FontSize',15,'FontWeight','bold');
ylabel('Difference ||.||_F','FontSize',15,'FontWeight','bold');
set(gca,'fontsize',15);
legend('NMF','K-SVD','||V - V_{noisy}||_F','Location','northwest');
str = sprintf('rec_difference_BBNLS_ksvd');
print('-depsc',str);
hold


figure(2);
clf;
hold
plot(100*diffNMF1(:,1),diffNMF1(:,5),'r*-','linewidth',7);
plot(100*diffOMP1(:,1),diffOMP1(:,5),'bo-','linewidth',7);
plot(100*diffNMF1(:,1),diffNMF1(:,7),'m--','linewidth',7);
grid on;
xlabel('Noise level (%)','FontSize',15,'FontWeight','bold');
ylabel('Difference ||.||_F','FontSize',15,'FontWeight','bold');
set(gca,'fontsize',15);
legend('NMF','K-SVD','SSIM(V,V_{noisy})');
str = sprintf('rec_ssim_index_BBNLS_ksvd');
print('-depsc',str);
hold



% Compute sparsities of H 
sparHNMF(:,1)  = diffNMF1(:,1);
sparHKSVD(:,1) = diffNMF1(:,1);	
for i = 1:size(HsKSVD,3)
	sparHNMF(i,2)  = sparsity(HsNMF(:,:,i));
	sparHKSVD(i,2) = sparsity(HsKSVD(:,:,i));
end

%Plot sparsity(H) vs. noiselevel
figure(3);
clf;
hold
plot(100*sparHNMF(:,1),sparHNMF(:,2),'r*-','linewidth',7);
plot(100*sparHKSVD(:,1),sparHKSVD(:,2),'bo-','linewidth',7);
grid on;
xlabel('Noise level (%)','FontSize',15,'FontWeight','bold');
ylabel('sparsity(H)','FontSize',15,'FontWeight','bold');
set(gca,'fontsize',15);
legend('NMF','K-SVD');
str = sprintf('sparH_BB_ksvd');
print('-depsc',str);
hold


%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot reconstruction errors in terms of Frob. norm
% in Step 1 and Step 2
%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Load data 5 \n');
load data/raw_denoise_OMPdata.mat diffvec WHimgs Hs
diffOMP2   = diffvec;
WHimgsKSVD = WHimgs;
HsKSVD     = Hs;
fprintf('Load data 6 \n');
load data/raw_denoiseNMFdata.mat diffvec WHimgs Vnoisedimgs Hs
diffNMF2 = diffvec;
WHimgsNMF= WHimgs;
HsNMF    = Hs;
fprintf('Load data 7 \n');
load data/test_denoise_TV.mat diffvec Vrecimgs
diffTV2  = diffvec;

figure(1);
clf;
hold
plot(100*diffNMF1(:,1),diffNMF1(:,2),'b*-','linewidth',7);
plot(100*diffNMF2(:,1),diffNMF2(:,2),'r*-','linewidth',7);
plot(100*diffOMP1(:,1),diffOMP1(:,2),'bo-','linewidth',7);
plot(100*diffOMP2(:,1),diffOMP2(:,2),'ro-','linewidth',7);
plot(100*diffNMF2(:,1),diffNMF2(:,4),'m--','linewidth',7);
grid on;
xlabel('Noise level (%)','FontSize',15,'FontWeight','bold');
ylabel('Difference ||.||_F','FontSize',15,'FontWeight','bold');
set(gca,'fontsize',15);
legend('NMF: Test 1.','NMF: Test 2.','K-SVD: Test 1.','K-SVD: Test 2.','||V - V_{noisy}||_F','Location','northwest');
str = sprintf('rec_diffs_frob_ksvd_BB');
print('-depsc',str);
hold



%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot reconstruction errors in terms of Frob. norm and SSIM
% in raw denoising
%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot differences ||V - Vrec|| yielded by different
% methods, NMF, KSVD and TV

% Plot reconstruction errors of NMF, K-SVD and TV
% in terms of Frobenius norm
figure(2);
clf;
hold
plot(100*diffNMF2(:,1),diffNMF2(:,2),'r*-','linewidth',7);
plot(100*diffOMP2(:,1),diffOMP2(:,2),'bo-','linewidth',7);
plot(100*diffTV2(:,1),diffTV2(:,2),'gd-','linewidth',7);
plot(100*diffNMF2(:,1),diffNMF2(:,4),'m--','linewidth',7);
grid on;
xlabel('Noise level (%)','FontSize',15,'FontWeight','bold');
ylabel('Difference, ||.||_F','FontSize',15,'FontWeight','bold');
set(gca,'fontsize',15);
legend('NMF','K-SVD','TV','Location','northwest');
str = sprintf('diff_BB_ksvd_TV');
print('-depsc',str);
hold


%Plot reconstruction errors of NMF, K-SVD and TV
%in terms of SSIM
figure(3);
clf;
hold
plot(100*diffNMF2(:,1),diffNMF2(:,5),'r*-','linewidth',7);
plot(100*diffOMP2(:,1),diffOMP2(:,5),'bo-','linewidth',7);
plot(100*diffTV2(:,1),diffTV2(:,5),'gd-','linewidth',7);
plot(100*diffNMF2(:,1),diffNMF2(:,7),'m--','linewidth',7);
xlabel('Noise level (%)','FontSize',20,'FontWeight','bold');
ylabel('SSIM index','FontSize',20,'FontWeight','bold');
set(gca,'fontsize',15);
grid on;
legend('NMF','K-SVD','TV','Location','northeast');
str = sprintf('ssim_BB_ksvd_TV');
print('-depsc',str);
hold




%%%%%%%%%%%%%%%%%%%%%%%%%
% Zoom the reconstructions without raw denoising
%%%%%%%%%%%%%%%%%%%%%%%%%

% Visualize zoomed Vnoisy

for i = 1:size(Vnoisedimgs,3)
        namestr = sprintf('Vnoisedimgzoom%.0fnl.jpg',100*diffvec(i,1));

        figure(5);
        clf;
        imagesc(Vnoisedimgs(10:20*8,10:20*8,i)); axis off; axis image; colormap(gray);
        saveas(5,namestr,'jpg');
end

% Visualize zoomed reconstructions of NMF

for i = 1:size(WHimgsNMFrec,3)
        namestr = sprintf('WHreczoomNMF%.0fnl.jpg',100*diffvec(i,1));

        figure(5);
        clf;
        imagesc(WHimgsNMFrec(10:20*8,10:20*8,i)); axis off; axis image; colormap(gray);
        saveas(5,namestr,'jpg');
end


% Visualize zoomed reconstructions of KSVD

for i = 1:size(WHimgsKSVDrec,3)
        namestr = sprintf('WHreczoomKSVD%.0fnl.jpg',100*diffvec(i,1));

        figure(5);
        clf;
        imagesc(WHimgsKSVDrec(10:20*8,10:20*8,i)); axis off; axis image; colormap(gray);
        saveas(5,namestr,'jpg');
end




%%%%%%%%%%%%%%%%%%%%%%%%%
% Zoom the reconstructions in raw denoising
%%%%%%%%%%%%%%%%%%%%%%%%%

% Visualize zoomed Vnoisy

for i = 1:size(Vnoisedimgs,3)
        namestr = sprintf('Vnoisedimgzoom%.0fnl.jpg',100*diffvec(i,1));

        figure(5);
        clf;
        imagesc(Vnoisedimgs(10:20*8,10:20*8,i)); axis off; axis image; colormap(gray);
        saveas(5,namestr,'jpg');
end


% Visualize zoomed reconstructions of NMF

for i = 1:size(WHimgsNMF,3)
        namestr = sprintf('WHrawreczoomNMF%.0fnl.jpg',100*diffvec(i,1));

        figure(5);
        clf;
        imagesc(WHimgsNMF(10:20*8,10:20*8,i)); axis off; axis image; colormap(gray);
        saveas(5,namestr,'jpg');
end


% Visualize zoomed reconstructions of KSVD

for i = 1:size(WHimgsKSVD,3)
        namestr = sprintf('WHrawreczoomKSVD%.0fnl.jpg',100*diffvec(i,1));

        figure(5);
        clf;
        imagesc(WHimgsKSVD(10:20*8,10:20*8,i)); axis off; axis image; colormap(gray);
        saveas(5,namestr,'jpg');
end

% Visualize zoomed reconstructions of TV

for i = 1:size(Vrecimgs,3)
        namestr = sprintf('VrecTVzoom%.0fnl.jpg',100*diffvec(i,1));

        figure(5);
        clf;
        imagesc(Vrecimgs(10:20*8,10:20*8,i)); axis off; axis image; colormap(gray);
        saveas(5,namestr,'jpg');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualize atom distributions in step2 (raw denoising)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:size(HsKSVD,3)
	namestr = sprintf('atom_distribution_rawrec_KSVD%.0fnl.eps',100*diffvec(i,1));
	visualize_atom_distribution(HsKSVD(:,:,i),namestr);
end

for i = 1:size(HsNMF,3)
        namestr = sprintf('atom_distribution_rawrec_NMF%.0fnl.eps',100*diffvec(i,1));
        visualize_atom_distribution(HsNMF(:,:,i),namestr);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualize noise sample
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load data/learn_noiseNMFdata.mat V

namestr = sprintf('noise_sample.jpg');
[figind] = visualize_image(V,namestr);
