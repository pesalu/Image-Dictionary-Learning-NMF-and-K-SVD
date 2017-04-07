%Visualize the data given by dictionaryNMF.m

%function [] = visualize_data(diff,dataWH,dataH,dataW)

DIFFIMG=figure;
%set(diff_img,'Visible','off');
plot(diff(:,1),diff(:,2),'bo-','LineWidth',2);
grid on;
xlabel('Number of iteration','FontSize',20); ylabel('||V-WH||_F','FontSize',20);
set(gca,'fontsize',15);
%title('diff vs iteration')
tightPos=get(gca,'TightInset');
noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
  tightPos(3:4))];
set(gca,'Position',noDeadSpacePos);
imgname=sprintf('diff_vs_iter_r%d',natoms);
print('-depsc',imgname)
%saveas(DIFFIMG,imgname,'eps');

diff_img=figure; set(diff_img,'Visible','off');
%subplot(8,2,1:4)
plot(dataWH(:,1),dataWH(:,2),'b.-','LineWidth',2); xlabel('Number of iterations'); ylabel('||V-WH||_F'); grid on;
%title('diff vs iteration')
tightPos=get(gca,'TightInset');
noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
  tightPos(3:4))];
set(gca,'Position',noDeadSpacePos);
imgname=sprintf('diff_vs_subiter_r%d',natoms);
print('-depsc',imgname);
%saveas(diff_img,imgname,'eps');

alphalambda_img=figure; set(alphalambda_img,'Visible','off');
%subplot(8,2,5:8)
plot(dataWH(:,1),log(dataWH(:,3)),'r'); xlabel('Number of iteration'); ylabel('log( alpha \times lambda )'); grid on;
 %title('alpha*lambda vs iteration')
tightPos=get(gca,'TightInset');
noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
  tightPos(3:4))];
set(gca,'Position',noDeadSpacePos);
imgname=sprintf('alphalambda_r%d',natoms);
print('-depsc',imgname);
%saveas(alphalambda_img,imgname,'eps');

sparsityH_img=figure; set(sparsityH_img,'Visible','off');
%subplot(8,2,9:12)
 plot(dataH(:,1),dataH(:,6),'b.'); xlabel('Number of iterations'); ylabel('sparsity(H)'); grid on;
 %title('Sparseness vs iteration');
tightPos=get(gca,'TightInset');
noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
  tightPos(3:4))];
set(gca,'Position',noDeadSpacePos);
imgname=sprintf('sparsityH_r%d',natoms);
print('-depsc',imgname);
%saveas(sparsityH_img,imgname,'eps');

sparsityW_img=figure; set(sparsityW_img,'Visible','off');
%subplot(8,2,13:16)
 plot(dataW(:,1),dataW(:,6),'b.'); xlabel('Number of iterations'); ylabel('sparsity(W)'); grid on;
 %title('Sparseness vs iteration');
tightPos=get(gca,'TightInset');
noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
  tightPos(3:4))];
set(gca,'Position',noDeadSpacePos);
imgname=sprintf('sparsityW_r%d',natoms);
print('-depsc',imgname);
%saveas(sparsityW_img,imgname,'eps');

%end
