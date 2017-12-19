
function res = rectest (Y)


for i = 1:9
    filename = sprintf('pattern_%d',i);
    load (filename,'X');
    P{i} = X;
end

filename = 'pattern_0';
    load (filename,'X');
    P{10} = X;


res = 0;
DP = dp_asym(P{10},Y);
min = DP.dist;
for i = 1:9
    DP = dp_asym(P{i},Y);
    t = DP.dist;
    if (t < min)
        res = i;
        min = t;
    end
end

