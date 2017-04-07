function [H,grad,iter,data]=nlssubprobBB(V,W,Hinit,tol,maxiter,lambda)

%number of elements in Hinit
nH=numel(Hinit);
%coeff. for computing the sparseness
cS=1.0/(sqrt(nH)-1);
%Sparseness of H, Spar in [0,1]
Spar=0.0;

%data matrix
data=zeros(maxiter,6);


H = Hinit;

%
WtV=W'*V;
WtW=W'*W;

%initial step size
alpha=1;

%initial BB step
if lambda==0.0
	lambda=1;
end

%sigma coefficient
sigma=0.01;

%step size decreasing constant
beta=0.1;


%BEGIN main loop
for iter=1:maxiter
     %iter
     if iter>1
	     %Previous grad
	     gradp=grad;
     end
     %New grad
     grad = WtW*H - WtV;

     if iter>1
	gr=grad-gradp;
     end
     %new grad minus previous grad

     projgrad = norm(grad(grad<0 | H>0));
%     if projgrad < tol %???
%         break
%     end

     %search step size
     for inner_iter=1:20,
	%inner_iter
         Hn = max(H-alpha*lambda*grad,0);
         d=Hn-H;
         %inner matrix product between matrices
         %grad(f(H^k)) and (H^k+1 - H^k)
         gradd=sum(sum(grad.*d));

         %inner matrix product between matrices
         %H^k+1-H^k and WtW*(H^k+1-H^k)
         dQd=sum(sum((WtW*d).*d));

         %the condition 3.2 and 4.3
         suff_decr = (1-sigma)*gradd + 0.5*dQd < 0;

         if inner_iter==1,
             %If condition 3.2 does not satisfy
             %(i.e. f(x^k+1)-f(x^k) !< sigma grad(f(x^k))(x^k+1-x^k) )
             %with the first iteration, its better to decrease
             %the value of alpha (step size) just in case,
             %i.e. decr_alpha = 1, if suff_decr = 0.
             %If suff_decr = 1, then increase alpha, i.e. decr_alpha = 0.
             decr_alpha = ~suff_decr;

             %previous H, denoted by Hp
             %gets the former value of H (i.e. the value of H^k)
             Hp=H;
         end

         if decr_alpha,
             if suff_decr,
                 H=Hn;
                 if iter>1
			 %Barzilai-Borwein step
			 s=sum(sum(d.*d));
			 y=sum(sum(d.*gr));
			 if y>0
				 lambda=s/y;
			 end
			 data(iter,4)=lambda;
		 end
                 %Store iteration step, difference (i.e. ||V-WH||), and alpha
                 data(iter,1)=iter;
                 %compute difference
                 D=V-W*H;
                 diff=sum(sum(D.*D));
                 data(iter,2)=sqrt(diff);
                 data(iter,3)=alpha*lambda;
                 break;
             else
                 %decrease the size of alpha
                 alpha=alpha*beta;
		 %alpha
             end
         else
             if ~suff_decr | Hp==Hn,
                 H=Hp;
                 if iter>1
                         %Barzilai-Borwein step
                         s=sum(sum(d.*d));
                         y=sum(sum(d.*gr));
                         if y>0
                                 lambda=s/y;
                         end
                         data(iter,4)=lambda;
                 end
                 %Store iteration step, difference (i.e. ||V-WH||), and alpha
                 data(iter,1)=iter+inner_iter;
                 %compute difference
                 D=V-W*H;
                 diff=sum(sum(D.*D));
		 %diff=trace(D'*D)
                 data(iter,2)=sqrt(diff);
                 data(iter,3)=alpha*lambda;
		 data(iter,5)=alpha;
%		 data(iter,6)=numel(H(H<0.5));
%		 for js=1:size(Hinit,2)
%			Spar=Spar + cS*( sqrt(nH)-(norm(H(:,js),1)/norm(H(:,js),2)) );
%		 end
%		 Spar=Spar/size(Hinit,2);
		 Spar=sparsity(H);
		 data(iter,6)=Spar;
		 %fprintf('%d   %f   %f\n',data(iter,1),data(iter,2),data(iter,4));
                 break;
             else
                 %increase the size of alpha
                 alpha = alpha/beta;
                 %previous H gets the latest H
                 Hp=Hn;
             end
         end



     end


end

