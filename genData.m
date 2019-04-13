function [x,y]=genData(m,n)
%A script for generating example noisy data
%The script generates m samples of additively Guassianly noisy data according to f in n
%dimensions with random std  and 0 mean
z = (randn/100+1/10)*randn(m,1);
x=2*randi(m,m,n)/m-1;
coeffsNum=randi((n+2)^2);
coeffs=randn(coeffsNum,1);
y=0;
pows=[0 0;randi((n+2)^2,coeffsNum-1,n)];
for i=1:coeffsNum
    C=1;
    for j=1:size(x,2)
        C=C.*x(:,j).^pows(i,j);
    end
    y=y+coeffs(i)*C;
end
y=y+z;
end