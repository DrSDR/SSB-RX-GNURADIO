

pkg load signal


fs = 96e3;

fc = 5e3 / (fs/2) ;

h = fir1(1024,fc);


x = audioread('s1.wav');
x = x.';
x = x / max(x);
x = resample(x,2,1);
x = filter(h,1,x);
x = x / max(x);

n = length(x);

t = [1:n]/fs;

iq = hilbert(x) .* exp(1i*2*pi*32140*t);

x = audioread('s2.wav');
x = x.';
x = x / max(x);
x = resample(x,2,1);
x = filter(h,1,x);
x = x / max(x);

iq = iq + hilbert(x).*exp(-1i*2*pi*12000*t);


x = audioread('s3.wav');
x = x.';
x = x / max(x);
x = resample(x,2,1);
x = filter(h,1,x);
x = x / max(x);

iq = iq + conj( hilbert(x)) .* exp(-1i*2*pi*12000*t);


iq = iq / max( abs(iq));


iq = [ real(iq).'   imag(iq).'  ];


audiowrite('SSB_IQSig_96KHz.wav',iq,fs,'BitsPerSample',16);



