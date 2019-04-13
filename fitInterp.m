function y=fitInterp(x,fitRes)

n=fitRes.polynomialOrder;
coeffs=fitRes.coeffs;
coeffsNum=length(coeffs);
pows=genPowersList(n-1,size(x,2));
y=0;
for i=1:coeffsNum
    C=1;
    for j=1:size(x,2)
        C=C.*x(:,j).^pows(i,j);
    end
    y=y+coeffs(i)*C;
end
end