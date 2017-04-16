function [phi] = DiffusionSolver(xmin,xmax,d,ymin,ymax,e,h,D,E,S)
%DIFFUSIONSOLVER Summary of this function goes here
%   Detailed explanation goes here
n=(xmax-xmin)/d;
m=(ymax-ymin)/e;
if numel(D)==1;
    D=zeros(n,m)+D;
elseif numel(D)~=n*m
    return
end
if numel(E)==1;
    E=zeros(n,m)+E;
elseif numel(E)~=n*m
    return
end
if numel(S)==1;
    S=zeros(n,m)+S;
elseif numel(S)~=n*m
    return
end

end

