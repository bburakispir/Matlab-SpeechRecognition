function [X,data] = abhisprogram(sec)

data.T = sec;


data.fs = 8000;

data.samples = data.T * data.fs;


data.N=256;


data.shift = 10*data.fs/1000;


data.nofChannels = 22;

fs=data.fs;
N=data.N;
nofChannels=data.nofChannels;
df = fs/N; 
Nmax = N/2; 
fmax = fs/2; 
melmax = 2595 * log10(1 + fmax./700);


melinc = melmax / (nofChannels + 1); 


melcenters = (1:nofChannels) .* melinc;


fcenters =  700*((10.^(melcenters ./2595)) -1);


indexcenter = round(fcenters ./df);


indexstart = [1 , indexcenter(1:nofChannels-1)];
indexstop = [indexcenter(2:nofChannels),Nmax];

W = zeros(nofChannels,Nmax);
for c = 1:nofChannels
    
    increment = 1.0/(indexcenter(c) - indexstart(c));
    for i = indexstart(c):indexcenter(c)
        W(c,i) = (i - indexstart(c))*increment;
    end 
    
    decrement = 1.0/(indexstop(c) - indexcenter(c));
    for i = indexcenter(c):indexstop(c)
       W(c,i) = 1.0 - ((i - indexcenter(c))*decrement);
    end 
end 



for j = 1:nofChannels
    W(j,:) = W(j,:)/ sum(W(j,:)) ;
end
data.W=W;
data.s = wavrecord(data.samples,data.fs,'double');

W=data.W;
winShift=data.shift;
s=data.s;
[nofChannels,maxFFTIdx] = size(W);
fftLength = maxFFTIdx * 2;


SPEC = computeSpectrum(fftLength,winShift,s);



MEL.M = W * SPEC.X;


MEL.e = SPEC.e ;

data.MEL=MEL;
data.nofFrames = size(data.MEL.M,2);
data.nofMelChannels = size(data.MEL.M,1);

epsilon = 10e-5;
for k = 1:data.nofFrames
    for c = 1:data.nofMelChannels

        data.MEL.M(c,k) = data.MEL.M(c,k)/data.MEL.e(k);

        data.MEL.M(c,k) = loglimit(data.MEL.M(c,k),epsilon);
    end 
end 

X = data.MEL.M ;