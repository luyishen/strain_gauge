% support information for Shen and Playter, 2021, Geophysics
% contact luyi@ualberta.ca for issues
%
dep = 1e-6 % incremental difference to calculate derivatives; don't change
%%%%%%%%%%%%%%%%%%
ep2m = 5e-5 % input: strains reported by strain gages
ep3m = 3e-4 %
sample_diameter = 1.5% sample diameter is estimated to be 1.5 inch
% ep2 and ep3 are the out real strains.

% strain gage lengths of 0.39 inch 

gage_length = 0.39
[ep2, ep3, normD, ep2x, ep3x] = strain_correction_inversion(ep2m, ep3m, sample_diameter,gage_length)
[ep2_d, ~] = strain_correction_forward(ep2+dep,ep3,sample_diameter,gage_length)
dep2_dep2m = (ep2_d - ep2m)/dep
[~, ep3_d] = strain_correction_forward(ep2,ep3+dep,sample_diameter,gage_length)
dep3_dep2m = (ep3_d - ep3m)/dep

% gage length 0.12 inch
gage_length = 0.12
[ep2m, ep3m] = strain_correction_forward(ep2,ep3,sample_diameter,gage_length)
[ep2, ep3, normD, ep2x, ep3x] = strain_correction_inversion(ep2m, ep3m, sample_diameter,gage_length)
[ep2_d, ~] = strain_correction_forward(ep2+dep,ep3,sample_diameter,gage_length)
dep2_dep2m = (ep2_d - ep2m)/dep
[~, ep3_d] = strain_correction_forward(ep2,ep3+dep,sample_diameter,gage_length)
dep3_dep2m = (ep3_d - ep3m)/dep