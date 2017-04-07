function [asqrt]=isqrt(n)

%input:
%n=integer
%output:
%asqrt=integer approximation of square root of n

xk=0;
x0=5;
i=0;
while ~abs(xk-x0)<1
	i=i+1;
	if i==1;
		xk=0.5*(x0+n/x0);
	else
		x0=xk;
		xk=0.5*(x0+n/x0);
	end
end

asqrt=floor(xk);

end
