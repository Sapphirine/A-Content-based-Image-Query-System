function [d]=dset(a, b, AAA)

    %d = (a - b) * AAA * (a - b)';
    d = (a - b) * (a - b)';
    
end