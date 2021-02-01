% support information for Shen and Playter, 2021, Geophysics
% contact luyi@ualberta.ca for issues
function [ep2x, ep3x] = strain_correction_forward(ep2,ep3,R,w,theta1, theta2)
% this function could benifit from the usage of symolic math package(e.g,
% use command: digits(50))

if nargin < 5
    theta1 = 0;
    theta2 = 90;
end

phi = w/R;
n = 10000; % denometer for integration


arc_length_ep2 = 0;
for arc_ang = theta1-phi/2:phi/n:theta1+phi/2-phi/n
    arc_length_ep2 = arc_length_ep2+ sqrt(((R*cos(arc_ang)-R*cos(arc_ang+phi/n))*(1-ep3))^2+((R*sin(arc_ang)-R*sin(arc_ang+phi/n))*(1-ep2))^2);
end

arc_length_ep3 = 0;
for arc_ang = theta2-phi/2:phi/n:theta2+phi/2-phi/n
    arc_length_ep3 = arc_length_ep3+ sqrt(((R*cos(arc_ang)-R*cos(arc_ang+phi/n))*(1-ep3))^2+((R*sin(arc_ang)-R*sin(arc_ang+phi/n))*(1-ep2))^2);
end

ep2x = 1 - arc_length_ep2/w;
ep3x = 1 - arc_length_ep3/w;