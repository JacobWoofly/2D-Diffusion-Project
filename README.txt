DiffusionSolver(xmin,xmax,d,ymin,ymax,e,h,D,E,S

xmin= the x value of the left boundary
xmax= the x value of the right boundary
ymin= the y value of the bottom boundary
ymax= the y value of the top boundary
d= the bin size for x
e= the bin size for y
	(xmax-xmin)/d and (ymax-ymin)/e must both be integers n and m, respectively.

D= diffusion coefficient (single element = constant, n*m elements = E(x,y))
E= cross section (single element = constant, n*m elements = E(x,y))
S= source (single element = constant, n*m elements = E(x,y))
