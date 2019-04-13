function fit=LSQvsRLSQFit(x,y,fracDat,n,lam)
%Regularized and standard least squares approaches to nth-order N-D polynomial fits
%The algorithm uses a prescribed fraction of the input data to train the model.
%The resulting output is a fit structure which includes the fit properties and error (over the testing data)
%for both types of fit


fit1.type='Polynomial Least Squares';
fit2.type='Regularized Polynomial Least Squares';

fit1.polynomialOrder=n;
fit2.polynomialOrder=n;

fit1.regCoeff=0;
fit2.regCoeff=lam;

fit1.dataFractionForTraining=fracDat;
fit2.dataFractionForTraining=fracDat;

indDatTrain=unique(randi(length(x),floor(length(x)*fracDat),1));
indDatTest=setdiff(1:length(x),indDatTrain);

xTrain=x(indDatTrain,:);
yTrain=y(indDatTrain,:);

xTest=x(indDatTest,:);
yTest=y(indDatTest,:);

pows=genPowersList(n-1,size(xTest,2));
A=[];
for i=1:size(pows,1)
    C=1;
    for j=1:size(pows,2)
        C=C.*xTrain(:,j).^pows(i,j);
    end
    A=[A C];
end
coeffs1=((A'*A)^(-1))*(A'*yTrain);
coeffs2=((A'*A+lam*eye(size(A,2)))^(-1))*(A'*yTrain);
fit1.coeffs=coeffs1;
fit2.coeffs=coeffs2;

ATest=[];
for i=1:size(pows,1)
    C=1;
    for j=1:size(pows,2)
        C=C.*xTest(:,j).^pows(i,j);
    end
    ATest=[ATest C];
end

fit1.err=sqrt(sum((ATest*coeffs1-yTest).^2));
fit2.err=sqrt(sum((ATest*coeffs2-yTest).^2));

fit.fitLSQ=fit1;
fit.fitRLSQ=fit2;

end