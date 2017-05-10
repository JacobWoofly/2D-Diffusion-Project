DiffusionSolverClean(xmin,xmax,d,ymin,ymax,e,D,E,S, right, top, left, bottom)

xmin= the x value of the left boundary
xmax= the x value of the right boundary
ymin= the y value of the bottom boundary
ymax= the y value of the top boundary
d= the bin size for x
e= the bin size for y
	(xmax-xmin)/d+1 and (ymax-ymin)/e+1 must both be integers, as they define n and m, respectively.

D= diffusion coefficient (single element = constant, matrix or symbolic function = D(x,y))
E= cross section (single element = constant, matrix or symbolic function = E(x,y))
S= source (single element = constant, matrix or symbolic function = D(x,y))

right, top, left, and bottom: (single element = constant, vector or symbolic function = D(x,y), string: 'vacuum' 
is vacuum condition, other strings result in reflecting condition)

inputs.m has tests and example inputs.