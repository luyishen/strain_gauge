% support information for Shen and Playter, 2021, Geophysics
% contact luyi@ualberta.ca for issues
% strain correction function
% use bisection method
function [ep2, ep3, normD, ep2x, ep3x] = strain_correction_inversion(epsilon2_x, epsilon3_x, R, w, theta1, theta2)
%R radius of the sample
%w width of strain gauge
if nargin < 5
    theta1 = 0;
    theta2 = 90;
end
ep2 = epsilon2_x;
ep3 = epsilon3_x;

[ep2x, ep3x] = strain_correction_forward(ep2 ,ep3,R, w, theta1, theta2);

normD = ((ep2x - epsilon2_x)/epsilon2_x)^2 + ((ep3x - epsilon3_x)/epsilon3_x)^2;
normD_updated = 1;
while  normD > 1e-10
    
    normD = ((ep2x - epsilon2_x)/epsilon2_x)^2 + ((ep3x - epsilon3_x)/epsilon3_x)^2;
    
    [ep2x_ep2, ep3x_ep2] = strain_correction_forward(ep2+ep2/100 ,ep3,R, w, theta1, theta2);
    dep2xdep2 = (ep2x_ep2 - ep2x)/ep2*100;
    dep3xdep2 = (ep3x_ep2 - ep3x)/ep2*100;
    [ep2x_ep3, ep3x_ep3] = strain_correction_forward(ep2 ,ep3+ep3/100,R, w, theta1, theta2);
    dep2xdep3 = (ep2x_ep3 - ep2x)/ep3*100;
    dep3xdep3 = (ep3x_ep3 - ep3x)/ep3*100;
    J = [dep2xdep2 dep2xdep3
        dep3xdep2 dep3xdep3];
    depx = [ epsilon2_x - ep2x
             epsilon3_x - ep3x];
    
    dep = J\depx;
    ep2 = ep2+dep(1);
    ep3 = ep3 + dep(2);

    [ep2x, ep3x] = strain_correction_forward(ep2 ,ep3,R, w, theta1, theta2);
    
end



