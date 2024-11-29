clear
clc

addpath('qtfm')
 M=imread('butterfly.jpg');
 %M=imread('hkview.jpg');
 %M=imread('garden.jpg');
%  M=imread('van2.jpg');
 M=im2double(M);
 M = imresize(M,1/3);
 Mi=M(:,:,1);  Mj=M(:,:,2);  Mk=M(:,:,3);
 dataM=quaternion(Mi,Mj,Mk);

r=5;
k=5; maxiter=1000; epislon=1e-4;
initer=3;% parameter of power method 
rk=r+k;

 % ==== our method for model 1 (M: pure quaternion): Randomalized best approximation to pure quaternion ==== 
% tic
%  [Mapro_pureRand,disXY_pureRand,cnt_pureRand] = BestAproPureRan(dataM,r,initer,maxiter,epislon);
% tt_pureRand=toc


% err_pureRand=norm(Mapro_pureRand-dataM,'fro')/norm(dataM,'fro')

% ==== our method for model 2 (M: 4 components ) : Randomalized best approximation to positive quaternion ====

% sdataM_variant=(x(dataM)+y(dataM)+z(dataM))/sqrt(3);
%  xdataM_variant=x(dataM);
%  ydataM_variant=y(dataM);
%  zdataM_variant=z(dataM);
%  dataM_variant=quaternion(sdataM_variant,xdataM_variant, ydataM_variant,zdataM_variant);
%  
% tic
%  [Mapro_postv,disXY_postv,cnt_postv] = BestAproPositvRan(dataM_variant,r,initer,maxiter,epislon);
% tt_postv=toc
% err_postv_full=norm(Mapro_postv-dataM_variant,'fro')/norm(dataM_variant,'fro')
% 
% Mapro_postv_pure=Proj_nonneg(Mapro_postv);
% err_postv_pure=norm(Mapro_postv_pure-dataM,'fro')/norm(dataM,'fro')


% ==== compared method 1:  best positive pure approximation on M ====

 tic
 Mapro_pure = BestAproPure(dataM,r,maxiter,epislon);
 tt_pure=toc ;
 err_pure=norm(Mapro_pure-dataM,'fro')/norm(dataM,'fro') ;



% ==== compared method 2: randomalized for best approximation on M and
% project to positive pure.

%  tic
%  Mapro = BestAproRan(dataM,r,initer);
%  tt_ran=toc 
%  Mapro_rand = Proj_nonnegpure(Mapro); 
%  err_Rand=norm(Mapro_rand-dataM,'fro')/norm(dataM,'fro') 
  
 
% ==== compared method 3: randomalized for best approximation on M (4 components) and
% project to positive.
  
%  tic
%  Mapro_variant = BestAproRan(dataM_variant,r,initer);
%  tt_ranVariant=toc
% Mapro_variant_rand = Proj_nonneg(Mapro_variant);
% err_variant_Rand_full=norm(Mapro_variant-dataM_variant,'fro')/norm(dataM_variant,'fro')
% 
% Mapro_variant_randpure = Proj_nonnegpure(Mapro_variant_rand);
% err_variant_Rand_pure=norm(Mapro_variant_randpure-dataM,'fro')/norm(dataM,'fro')


%% ------------- show reconstructed imag --------------------------

% imag_gt = quaImgshow(dataM);
% imag_pureRand = quaImgshow(Mapro_pureRand);
% imag_postv = quaImgshow(Mapro_postv);
% imag_pure=quaImgshow(Mapro_pure);
% imag_rand = quaImgshow(Mapro_rand);
% imag_variant_rand_pure = quaImgshow(Mapro_variant_randpure);
%  
%  
%   figure 
%  subplot(231)
%  imagesc(imag_gt)
%  subplot(232)
%  imagesc(imag_pureRand)
%  subplot(233)
%  imagesc(imag_postv)
%  subplot(234)
%  imagesc(imag_pure)
%  subplot(235)
%  imagesc(imag_rand)
%   subplot(236)
%  imagesc(imag_variant_rand_pure)
 
 
 %save result_hkview_r15  Mapro_pureRand  Mapro_postv  Mapro_pure  Mapro  Mapro_variant
 %(result_hkview_r05: 383.36s,60.17s,6041.41s, 0.17s, 0.17s)
  %(result_hkview_r20: 383.36s,60.17s,6210.41s, 0.42s, 0.71s)
  %(result_hkview_r10: 482.61s, 50.20s,6010.15s, 0.31s, 0.28s)
   %(result_hkview_r15: 626.43s, 33.38s, 5958.85s 0?24s, 0.32s)
   
   
 %save result_butterfly_r20  Mapro_pureRand  Mapro_postv  Mapro_pure  Mapro  Mapro_variant
 %(result_butterfly_r05: 312.68s,43.59s,4664.99s, 0.15s, 0.15s)
 %(result_butterfly_r10: 449.09s,39.33s,4664.99s, 0.22s, 0.22s)
  %(result_butterfly_r15: 574.89s,17.71s, 4676.71s,0.30s,0,29s.)
   %(result_butterfly_r15: 696.25s,713.99s, 4967.98s, 0.35,0.34.)
   
   %save result_garden_r20  Mapro_pureRand  Mapro_postv  Mapro_pure  Mapro  Mapro_variant
   %(result_garden_r05: 349.79s,86.55s,4946.90s, 0.17s, 0.20s) 
   %(result_garden_r10: 464.58s,52.50s,5248.70s, 0.24s, 0.25s) 
   %(result_garden_r15: 572.79s,48.46s, 4971.60s, 0.33s,0.33s) 
   %(result_garden_r20: 375.72 s, 26.89s, 2552.90s, 0.35s, 0.36s) 
   
%   save result_van_r15  Mapro_pureRand  Mapro_postv  Mapro_pure  Mapro  Mapro_variant
  %(result_garden_r05: 185.83s,13.24s, 3366.00s, 0.1823 s,  0.1748s) 
   %(result_garden_r10: 263.07s,1426.8s, 3382.10s, 0.2594 s,  0.2418s) 
 %% ---------- functions ---------------------
 
%  function img=quaImgshow(M)
%  %% M is a given quaternion
%  
%  Mi=x(M); Mj=y(M); Mk=z(M);
%  [ir,ic]=size(M);
%  
%  img=zeros(ir,ic,3);
%  img(:,:,1)=Mi;
%  img(:,:,2)=Mj;
%  img(:,:,3)=Mk; 
% end