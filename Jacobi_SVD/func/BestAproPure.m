function [Mapro_LR,Mapro_PJ,disXY,cnt] = BestAproPure(M,r,maxiter,epislon)

[m,n]=size(M);
X=M; Y=zerosq(m,n);
cnt=1;
dis=1e5;  

%&&
while cnt<=maxiter && dis>=epislon
    
    Xpre=X;    Ypre=Y;
    
%%==== Apply SVD on  X and Construct (Ur,Sr,Vr) ====

[U0,S0,V0]=qsvd_para(X,1e-5,100); 
S0 = diag(S0);
Ur=U0(:,1:r); Sr=S0(1:r,1:r); Vr=V0(:,1:r);

Y=Ur*Sr*Vr';
 
%%==== Projection on Omega 2 ====

%Xi=max(x(Y),1e-6); Xj=max(y(Y),1e-6); Xk=max(z(Y),1e-6);
Xi=x(Y);  Xj=y(Y);  Xk=z(Y);
X=quaternion(Xi,Xj,Xk);
 

 disX=norm(X-Xpre,'fro');
 disY=norm(Y-Ypre,'fro');
 disXY=norm(X-Y,'fro'); 
 disV=[disX,disY,disXY]
 dis=max(disV);
  
cnt=cnt+1;
cnt
end

Mapro_LR=Y;
Mapro_PJ=X;