clc, clear all, close all
%Generate data
m=50000;
n=2;
[x,y]=genData(m,n);


%Generate fit
fracDat=.005;%Fraction of data used for training purposes
p=9;%Fit polynomial order
lam=0.25;%Regularization coefficient
fitRes=LSQvsRLSQFit(x,y,fracDat,p,lam);

