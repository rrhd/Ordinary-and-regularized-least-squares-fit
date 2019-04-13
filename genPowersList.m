function pows=genPowersList(n,m)
%Generates list of m length vectors with numbers between 0 and n and that
%sum to at most n
p=(n+1)^m;
pows=zeros(p,m);
for i=1:m
    c=kron((0:n)',ones(p/(n+1)^i,1));
    pows(:,i)=repmat(c,[(n+1)^(i-1) 1]);
end
pows=pows((sum(pows,2)<=(n+1)),:);
end