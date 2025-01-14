#!/bin/bash
source ../env.iris.sh

cmake -DTHRUST_INCLUDE_DIRS=$HOME/Code/thrust \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DTHRUST_INCLUDE_DIR=$HOME/Code/thrust \
    -DNETCDF_DIR=$NETCDF \
    -DNETCDF_CXX_ROOT=$NETCDFCXX4 \
    -DNETCDF_LIBRARIES=$NETCDFLIB \
    -DNETCDF_INCLUDE_DIRS=$NETCDFINCLUDE \
    -DNETCDF_CXX_INCLUDE_DIR=$NETCDFCXX4INCLUDE \
    -DNETCDF_CXX_LIBRARY=$NETCDFLIBCXX_CPP \
    -DNETCDF_INCLUDE_DIR=$NETCDFINCLUDE \
    -DNETCDF_LIBRARY=$NETCDFLIB \
    -DNETCDF_CXX_LIBRARY=$NETCDFLIB_CPP \
    -DLIBCONFIGPP_LIBRARY=$LIBCONFIGLIB \
    -DLIBCONFIGPP_INCLUDE_DIR=$LIBCONFIGPP_INCLUDE_DIRR \
    -DUSE_CUDA=0 \
    -DUSE_MPI=0 \
    -DUSEIONIZATION=1 \
    -DUSERECOMBINATION=1 \
    -DUSEPERPDIFFUSION=0 \
    -DUSECOULOMBCOLLISIONS=0 \
    -DUSEFRICTION=0 \
    -DUSEANGLESCATTERING=0 \
    -DUSEHEATING=0 \
    -DUSETHERMALFORCE=0 \
    -DUSESURFACEMODEL=1 \
    -DUSESHEATHEFIELD=0 \
    -DBIASED_SURFACE=0 \
    -DUSEPRESHEATHEFIELD=0 \
    -DBFIELD_INTERP=2 \
    -DLC_INTERP=0 \
    -DGENERATE_LC=0 \
    -DEFIELD_INTERP=0 \
    -DPRESHEATH_INTERP=0 \
    -DDENSITY_INTERP=2 \
    -DTEMP_INTERP=2 \
    -DFLOWV_INTERP=0 \
    -DGRADT_INTERP=0 \
    -DODEINT=0 \
    -DFIXEDSEEDS=1 \
    -DPARTICLESEEDS=1 \
    -DPARTICLE_SOURCE_SPACE=0 \
    -DPARTICLE_SOURCE_ENERGY=0 \
    -DPARTICLE_SOURCE_ANGLE=0 \
    -DPARTICLE_SOURCE_FILE=1 \
    -DGEOM_TRACE=0 \
    -DGEOM_HASH=3 \
    -DGEOM_HASH_SHEATH=3 \
    -DPARTICLE_TRACKS=1 \
    -DSPECTROSCOPY=2 \
    -DUSE3DTETGEOM=1 \
    -DUSECYLSYMM=1 \
    -DCHECK_COMPATIBILITY=1 \
    -DFORCE_EVAL=0 \
    -DFLUX_EA=1 \
    -DUSEFIELDALIGNEDVALUES=0 \
    -DUSE_SORT=0 \
    ..
