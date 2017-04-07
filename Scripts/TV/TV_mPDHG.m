% Last Updated on 05-15-2013

% This program applies modified PDHG algorithm to solve the
% ROF image denoising model with nonnegativity constraint

% min ||\grad u||_1 + lbd/2 ||u-f||^2 s.t. u>=0

% \grad : gradient
%-------------------------------------------------------------------------
% Input variables
%-------------------------------------------------------------------------
% w1,w2:        Dual variable, initial guess. 
% f:            noisy image
% lbd:          Constant fidelity parameter. 
% NIT:          Maximum number of iterations
% GapTol:       Convergence tolerance (stop criterion) for relative duality gap
%--------------------------------------------------------------------------
%-------------------------------------------------------------------------
% Output variables
%-------------------------------------------------------------------------
% u:                Primal variable, numerical solution - restored image 
% w = (w1,w2):      Dual variable, numerical solution
% Energy:           The value of the dual objective function
% DGap:             Duality Gap
% TimeCost:        CPU time cost
% itr:              number of iterations

function [u, Energy,  TimeCost, itr] = ...
      TV_mPDHG(f,lbd,NIT,xTol,verbose)

[m,n]=size(f);                %Assume a square image        

gx = Dx(f);
gy = Dy(f);
w1=gx;
w2=gy;

  
%Compute the primal u
u  = f;
ux = gx;
uy = gy;
gu_norm = sqrt(ux.^2+uy.^2);
Primal(1) = sum(sum(gu_norm + (lbd/2)*(u-f).^2));
diffu=0;
if verbose
  fprintf(' Initial: Pri=%8.3e,xtol=%8.3e \n', ...
      Primal(1),diffu);
end

TimeCost(1)=0;
t0 = cputime;                %Start CPU clock
tau=sqrt(1/8)*2;
sigma=1/8/tau;

for itr=1:NIT
  
  % choose tau
 % tau=2.0;
 % tau = 0.2 + 0.08*itr;
  w1old=w1;
  w2old=w2;
  
  
  w1 = w1 - tau*ux; 
  w2 = w2 - tau*uy;
  
  %apply gradient projection to ensure constraints  
  wnorm= max(1, sqrt(w1.^2+w2.^2));
  w1 = w1./wnorm;
  w2 = w2./wnorm;

  w1bar=2*w1-w1old;
  w2bar=2*w2-w2old;
  
  DivW = Dxt(w1bar)+Dyt(w2bar);
  
  %Compute the primal u 
  % choose theta  
  uold=u;
  u=(u + sigma*lbd*(f +(1/lbd)*DivW))/(sigma*lbd+1);
  u(u<0)=0; % projection on negativity ball'; 
  ux = Dx(u);
  uy = Dy(u);
  gu_norm = sqrt(ux.^2+uy.^2);
  Primal(itr+1) = sum(sum(gu_norm + (lbd/2)*(u-f).^2));
  
  TimeCost(itr+1)=cputime-t0;
  diffu=norm(uold-u)/norm(uold);
  if verbose
    fprintf(' PDHG itr %4d: Pri=%8.3e, xtol=%5.2e\n', itr, ...
	Primal(itr+1),  diffu);
  end
  % test for convergence stop criterion:  (Primal-Dual)/Dual < tol
  % Dual Energy = 0.5*lbd*||f||^2 - (1/lbd)*||\div w - lbd *f||^2
  if ( diffu< xTol )
    if verbose
      fprintf(1,' PDHG convergence tolerance %7.3e satisfied\n', xTol);
    end 
    break
  end   
end




function d = Dx(u)
[rows,cols] = size(u); 
d = zeros(rows,cols);
d(:,2:cols) = u(:,2:cols)-u(:,1:cols-1);
d(:,1) = u(:,1)-u(:,cols);
return

function d = Dxt(u)
[rows,cols] = size(u); 
d = zeros(rows,cols);
d(:,1:cols-1) = u(:,1:cols-1)-u(:,2:cols);
d(:,cols) = u(:,cols)-u(:,1);
return

function d = Dy(u)
[rows,cols] = size(u); 
d = zeros(rows,cols);
d(2:rows,:) = u(2:rows,:)-u(1:rows-1,:);
d(1,:) = u(1,:)-u(rows,:);
return

function d = Dyt(u)
[rows,cols] = size(u); 
d = zeros(rows,cols);
d(1:rows-1,:) = u(1:rows-1,:)-u(2:rows,:);
d(rows,:) = u(rows,:)-u(1,:);
return
