% a
N=10;    X = rand(1,N);

% b
m = mean(X)

% c
N=10;
for i=1:10000,
    X = rand(1,N);
    media(i)=mean(X);
end
hist(media)

% d
N=100;
for i=1:10000,
    X = rand(1,N);
    media100(i)=mean(X);
end
hist(media100)

N=1000;
for i=1:10000,
    X = rand(1,N);
    media1000(i)=mean(X);
end
hist(media1000)

% e
m1 = mean(media)
m2 = mean(media100)
m3 = mean(media1000)

v1 = var(media)
v2 = var(media100)
v3 = var(media1000)

% f
N=10;
for i=1:10000,
    X = chirnd(1,N);
    media(i)=mean(X);
end
hist(media)

for i=1:10000,
    X = frnd(1,N);
    media(i)=mean(X);
end
hist(media)

for i=1:10000,
    X = rand(1,N).^2;
    media(i)=mean(X);
end
hist(media)
