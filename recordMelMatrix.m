function X = recordMelMatrix(sec)

data.T = sec;

data.fs = 8000;

data.samples = data.T * data.fs;

data.N=256;

data.shift = 10*data.fs/1000;

data.nofChannels = 22;

data.W = melFilterMatrix(data.fs,data.N,data.nofChannels);

data.s = wavrecord(data.samples,data.fs,'double');
wavplay(data.s,data.fs);

data.MEL = computeMelSpectrum(data.W,data.shift,data.s);
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
