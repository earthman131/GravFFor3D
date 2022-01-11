function Uz = forward_Uz(pex,G,nx,ny,nz,npts,dx,dy,dz)
[k,kx,ky,kz] = wave3d(npts,dx,dy,dz);
pf=fftshift(fftn(pex));
ydiff=floor((npts-ny)/2);xdiff=floor((npts-nx)/2);zdiff=floor((npts-nz)/2);
Uzf=(4*pi*G)*pf.*(1i*kz+eps)./(k.^2+eps);
Uz=ifftn(ifftshift(Uzf));
Uz=real(Uz((ydiff+1):(ydiff+ny),(xdiff+1):(xdiff+nx),(zdiff+1):(zdiff+nz)))*1e5;  
Uz=Uz(:,:,1); 
end