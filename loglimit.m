function y = loglimit(x,limit)

if (x < limit)
    y = log(limit);
else
    y = log(x);
end;