function [d] = distance(colorset1, colorset2, centroid1, centroid2, area1, area2, mbr1, mbr2, a1, a2, a3, a4, AAA)
    d1 = dset(colorset1, colorset2, AAA);
    d2 = dloc(centroid1, centroid2);
    d3 = dsize(area1, area2);
    d4 = dmbr(mbr1, mbr2);
    d = a1 * abs(d1) + a2 * abs(0.3 * d2) + a3 * abs(0.001 * d3) + a4 * abs(0.1 * d4);
end