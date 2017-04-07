function [A]=OMP(D,X,L); 
%=============================================
% Sparse coding of a group of signals based on a given 
% dictionary and specified number of atoms to use. 
% input arguments: 
%       D - the dictionary (its columns MUST be normalized).
%       X - the signals to represent
%       L - the max. number of coefficients for each signal.
% output arguments: 
%       A - sparse coefficient matrix.
%=============================================
[n,P]=size(X);
[n,K]=size(D);
for k=1:1:P,
    a=[];
    %Choose the v_i=x
    x=X(:,k);
    residual=x;
    indx=zeros(L,1);
    for j=1:1:L,
        proj=D'*residual;
        %Compute the differences and order in descending fashion
        [maxVal,pos]=max(abs(proj));
        %Take the index that correspond the smallest difference
        pos=pos(1);
        %Store the chosen index into indx(j)=S_j 
        indx(j)=pos;
        %Update the coefficient column a corresponding the column v_i
        %pinv(D) gives the pseudo-inverse of D, i.e. Moore-Penrose inverse
        %of D
        a=pinv(D(:,indx(1:j)))*x;
        residual=x-D(:,indx(1:j))*a;
        if sum(residual.^2) < 1e-6
            break;
        end
    end;
    temp=zeros(K,1);
    temp(indx(1:j))=a;
    A(:,k)=sparse(temp);
end;
return;
