% Description of the input parameters: 
%       infile_msh: model mesh file
%       infile_mod: model density file, unit: g/cm^3
% Description of the output parameters: 
%       outfile_Uz: calculated anomaly
% Description of primary identifiers：
%       x, y: x, y verctor
%       nx, ny: number of points in x and y directions
%       dx, dy: spacing in x and y directions
%       npts: extension points
%       p：density distribution, unit: g/cm^3
%       G：gravitational constant, unit: m^3/kg·s^2
%       pex：density distribution after extension
%       Uz：gravity anomaly, unit: mGal
% Description of subroutine function: 
%       readmsh.m: read mesh file
%       readmod.m: read model file
%       wave3d.m: calculate wave number
%       extend_copy3d.m: copy edge extension
%       forward_Uz.m: calculated gravity anomaly
%       savegrd.m: save surfer text grd file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;
%%%%%%%%%%%% I/O parameters %%%%%%%%%%%%%
infile_msh = 'model_stack5_101_101_41.msh'; 
infile_mod = 'model_stack5_101_101_41.mod';
outfile_Uz = 'Uz_3D.grd'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,y,z,nx,ny,nz,dx,dy,dz] = readmsh(infile_msh);
p = readmod(infile_mod,nx,ny,nz); p = p*1000; 
nmax = max([nx ny nz]);
npts = 2^nextpow2(nmax);
pex = extend_copy3d(p,nx,ny,nz,npts); 
G = 6.67e-11;  
% forward 
Uz = forward_Uz(pex,G,nx,ny,nz,npts,dx,dy,dz); 
% save
savegrd(Uz,x,y,nx,ny,outfile_Uz);
