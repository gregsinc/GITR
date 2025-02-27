clear all
close all

nP=1e3;
nT=1e4;
v0 = 3e3;
flowV0 = 0*1e4;
T=20;
m1 = 184*1.66e-27;
m2 = 2*1.66e-27;
load('nu.mat')
dt = 1e-6;
k = 1.38e-23*11604; 

vx=zeros(1,nP);
vy=zeros(1,nP);
vz=v0*ones(1,nP);

flowVx=flowV0*ones(1,nP);
flowVy=zeros(1,nP);
flowVz=zeros(1,nP);

meanSpeed = sqrt(2*k*T/(m2));
meanSpeedImp = sqrt(2*k*T/(m1));

B = m2/(2*T*k);
vgrid = linspace(0,3*meanSpeed);
fvb = sqrt(B/pi)*exp(-B*vgrid.^2);
fvb = (B/pi)^(3/2)*4*pi*vgrid.*vgrid.*exp(-B*vgrid.^2);
fvbCDF = cumsum(fvb);
fvbCDF = fvbCDF./fvbCDF(end);
figure(1)
plot(vgrid,fvb)
B_unit = [0,0,1];
Tt = zeros(1,nT);
Tt2 = zeros(1,nT);
vzs = zeros(1,nT);
tic
for i=1:nT
    if (sum(isnan(vx)))
        stop
    end
    vPartNorm = sqrt(vx.^2 + vy.^2 + vz.^2);
    vxRelative = vx - flowVx;
    vyRelative = vy - flowVy;
    vzRelative = vz - flowVz;
    vRel2 = vxRelative.^2 + vyRelative.^2 + vzRelative.^2;
    E = 0.5*m1/1.602e-19*vRel2;
    vRelativeNorm = sqrt(vRel2);
    if (sum(find(vRelativeNorm>1e6)))
        stop
    end
    d_parx = vxRelative./vRelativeNorm;
    d_pary = vyRelative./vRelativeNorm;
    d_parz = vzRelative./vRelativeNorm;
    factor0 = B_unit(1)*d_parx + B_unit(2)*d_pary + B_unit(3)*d_parz;
    thisInd = find(abs(factor0-1) < 1e-5);
        factor1 = 1./sqrt(1-factor0.^2);
        e1x = factor1 .* ((factor0.*d_parx) - B_unit(1));
        e1y = factor1 .* ((factor0.*d_pary) - B_unit(2));
        e1z = factor1 .* ((factor0.*d_parz) - B_unit(3));
        factor1 = -1*factor1;
        e2x = factor1 .* (B_unit(3)*d_pary - B_unit(2)*d_parz);
        e2y = factor1 .* (B_unit(1)*d_parz - B_unit(3)*d_parx);
        e2z = factor1 .* (B_unit(2)*d_parx - B_unit(1)*d_pary);  

        d_parx(thisInd) = 0.001;
        d_pary(thisInd) = 0.001;
        d_parz(thisInd) = 1;
        dparMag = sqrt(d_parz(thisInd).^2 + d_pary(thisInd).^2 + d_parz(thisInd).^2);
        d_parx(thisInd) = d_parx(thisInd)./dparMag;
        d_pary(thisInd) = d_pary(thisInd)./dparMag;
        d_parz(thisInd) = d_parz(thisInd)./dparMag;
        cn_theta = d_parz(thisInd);
        sn_theta = sqrt(d_parx(thisInd).^2 + d_pary(thisInd).^2);
        st0ind = find(sn_theta == 0);
        sn_theta(st0ind) = 0.001;
        sn_phi = d_pary(thisInd)./sn_theta;
        cn_phi = d_parx(thisInd)./sn_theta;
        e1x(thisInd) = cn_theta.*cn_phi;
        e1y(thisInd) = cn_theta.*sn_phi;
        e1z(thisInd) = -sn_theta;
        e2x(thisInd) = -sn_phi;
        e2y(thisInd) = cn_phi;
        e2z(thisInd) = 0;
%     s1 = d_parz;
%     s2 = sqrt(1-s1.*s1);
%     perp_direction1(:,1) = 1.0./s2.*(s1.*d_parx- B_unit(1));
%     perp_direction1(:,2) = 1.0./s2.*(s1.*d_pary- B_unit(2));
%     perp_direction1(:,3) = 1.0./s2.*(s1.*d_parz- B_unit(3));
%     perp_direction2(:,1) = 1.0./s2.*(B_unit(2)*d_parz-B_unit(3)*d_pary);
%     perp_direction2(:,2) = 1.0./s2.*(B_unit(3)*d_parx-B_unit(1)*d_parz);
%     perp_direction2(:,3) = 1.0./s2.*(B_unit(1)*d_pary-B_unit(2)*d_parx);
%      s20ind = find(s2==0 | abs(s1-1)<1.0e4);
%     perp_direction1(s20ind,1) =  s1(s20ind);
%     perp_direction1(s20ind,2) =  s2(s20ind);
%     perp_direction1(s20ind,3) = 0;
%     normPd1 = sqrt(perp_direction1(s20ind,1).^2 + perp_direction1(s20ind,2).^2  + perp_direction1(s20ind,3).^2 );
%     perp_direction1(s20ind,1) =  perp_direction1(s20ind,1)./normPd1;
%     perp_direction1(s20ind,2) =  perp_direction1(s20ind,2)./normPd1;
%     perp_direction1(s20ind,3) = perp_direction1(s20ind,3)./normPd1;
%     perp_direction2(s20ind,1) = d_parz(s20ind);
%     perp_direction2(s20ind,2) = d_parx(s20ind);
%     perp_direction2(s20ind,3) = d_pary(s20ind);
%     s1(s20ind) = d_parx(s20ind)'.*perp_direction1(s20ind,1)+d_pary(s20ind)'.*perp_direction1(s20ind,2)+d_parz(s20ind)'.*perp_direction1(s20ind,3);
%     s2(s20ind) = sqrt(1-s1(s20ind).*s1(s20ind));
%     perp_direction1(s20ind,1) = -1.0./s2(s20ind)'.*(d_pary(s20ind)'.*perp_direction2(s20ind,3)-d_parz(s20ind)'.*perp_direction2(s20ind,2));
%     perp_direction1(s20ind,2) = -1.0./s2(s20ind)'.*(d_parz(s20ind)'.*perp_direction2(s20ind,1)-d_parx(s20ind)'.*perp_direction2(s20ind,3));
%     perp_direction1(s20ind,3) = -1.0./s2(s20ind)'.*(d_parx(s20ind)'.*perp_direction2(s20ind,2)-d_pary(s20ind)'.*perp_direction2(s20ind,1));
%     normPd1 = sqrt(perp_direction1(s20ind,1).^2 + perp_direction1(s20ind,2).^2  + perp_direction1(s20ind,3).^2 );
%     perp_direction1(s20ind,1) =  perp_direction1(s20ind,1)./normPd1;
%     perp_direction1(s20ind,2) =  perp_direction1(s20ind,2)./normPd1;
%     perp_direction1(s20ind,3) = perp_direction1(s20ind,3)./normPd1;
%     p1norm = sum(perp_direction1.^2,2);
%     if(sum(p1norm) > nP)
%         stop
%     end
    n1 = normrnd(0,1,1,nP);
%     n2 = normrnd(0,1,1,nP);
%     n3 = normrnd(0,1,1,nP);
%     xsi = rand(1,nP);
    r1 = rand(1,nP);
%     r1y = rand(1,nP);
%     r1z = rand(1,nP);
    r2 = rand(1,nP);
    plumin1 = 2*floor(r1 + 0.5)-1;
    plumin2 = 2*floor(r2 + 0.5)-1;
%     vbx = interp1(fvbCDF,vgrid,r1x,'pchip',0);
%     vby = interp1(fvbCDF,vgrid,r1y,'pchip',0);
%     vbz = interp1(fvbCDF,vgrid,r1z,'pchip',0);
%     phix= 2*rand(1,nP)-1;
%     phiy= 2*rand(1,nP)-1;
%     phiz= 2*rand(1,nP)-1;
%     vbx = phix.*vbx;
%     vby = phiy.*vby;
%     vbz = phiz.*vbz;
%     vfx = collV(vx,vbx,m1,m2);
%     vfy = collV(vy,vby,m1,m2);
%     vfz = collV(vz,vbz,m1,m2);
    nu_s0 = interp1(Eparticle,nu_s,E,'pchip',nu_s(1));
    nu_par0 = interp1(Eparticle,nu_par,E,'pchip',nu_par(1));
    nu_d0 = interp1(Eparticle,nu_d,E,'pchip',nu_d(1));
    nu_E0 = interp1(Eparticle,nu_E,E,'pchip',nu_E(1));
    highEind = find(E > Eparticle(end));
    nu_s0(highEind) = nu_s(end);
    nu_par0(highEind) = nu_par(end);
    nu_E0(highEind) = nu_E(end);
    nu_d0(highEind) = nu_d(end);
    drift = -sqrt(2)*dt*nu_s0.*vRelativeNorm;
    coeff_par = n1.*sqrt(dt*abs(nu_E0).*vRel2);
    coeff_perp1 = plumin1.*sqrt(dt*0.5*nu_d0.*vRel2);
    coeff_perp2 = plumin2.*sqrt(dt*0.5*nu_d0.*vRel2);
    if((sum(d_parx.^2 + d_pary.^2 + d_parz.^2) - nP)/nP > 1e-5)
        stop
    end
    if((sum(e1x.^2 + e1y.^2 + e1z.^2) - nP)/nP > 1e-5)
        stop
    end
    if((sum(e2x.^2 + e2y.^2 + e2z.^2) - nP)/nP > 1e-5)
        stop
    end
    vCollx = drift.*d_parx + coeff_par.*d_parx + coeff_perp1.*e1x + coeff_perp2.*e2x;
    vColly = drift.*d_pary + coeff_par.*d_pary + coeff_perp1.*e1y + coeff_perp2.*e2y;
    vCollz = drift.*d_parz + coeff_par.*d_parz + coeff_perp1.*e1z + coeff_perp2.*e2z;
    %vCollNorm = sqrt(vCollx.*vCollx + vColly.*vColly + vCollz.*vCollz);
    vx = vx + vCollx;
    vy = vy + vColly;
    vz = vz + vCollz;
    E2 = 0.5*m1*(vx.^2 + vy.^2 + vz.^2)/1.602e-19;
    E3 = 0.5*m1*((vx - flowV0).^2 + vy.^2 + vz.^2)/1.602e-19;
    Tt(i) = mean(E2);
    Tt2(i) = mean(E3);
    vzs(i) = mean(vz);
end
toc
B = m1/(2*T*k);
vgrid = linspace(0,20000);
fvb = nT*sqrt(B/pi)*exp(-B*vgrid.^2);
fvb = nT*(B/pi)^(3/2)*4*pi*vgrid.*vgrid.*exp(-B*vgrid.^2);
vmag = sqrt((vx-0*flowV0).^2 +vy.*vy +vz.*vz);
edges = linspace(0,3e4);
figure(2)
h1=histogram(vmag,edges)
hold on
plot(vgrid,fvb*max(h1.Values)/max(fvb))

vgrid = linspace(-20000,20000);
fvb = nT*sqrt(B/pi)*exp(-B*vgrid.^2);
edges = linspace(-3e4,3e4);
figure(3)
h1=histogram(vx,edges)
hold on
plot(vgrid,fvb*max(h1.Values)/max(fvb))
histogram(vy,edges)
histogram(vz,edges)

figure(5)
plot(linspace(0,(nT-1)*dt,nT),Tt)
hold on
plot(linspace(0,(nT-1)*dt,nT),Tt2)

figure(6)
plot(linspace(0,(nT-1)*dt,nT),vzs)
function vf1 = collV(v1,v2,m1,m2)
vf1 = (m1-m2)./(m1+m2).*v1 + 2*m2/(m1+m2).*v2;
end
