function [Spar]=sparsity(Hinit)
		%number of elements in column of Hinit
		nH=numel(Hinit(:,1));
		%coeff. for computing the sparseness
		cS=1.0/(sqrt(nH)-1);
		%Sparseness of H, Spar in [0,1]
		Spar=0.0;		 
                 for js=1:size(Hinit,2)   
                        Spar = Spar + cS*( sqrt(nH)-(norm(Hinit(:,js),1)/norm(Hinit(:,js),2)) );
                 end
                 Spar=Spar/size(Hinit,2);
end
