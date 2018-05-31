#!/bin/bash
source ../env.mac.sh

cmake -DTHRUST_INCLUDE_DIR=/Users/tyounkin/code/thrust/ \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DNETCDF_CXX_INCLUDE_DIR=$NETCDFCXX4INCLUDE \
    -DNETCDF_CXX_LIBRARY=$NETCDFLIB_CPP \
    -DNETCDF_DIR=$NETCDFDIR \
    -DNETCDF_INCLUDE_DIR=$NETCDFINCLUDE \
    -DNETCDF_LIBRARY=$NETCDFLIB \
    -DNETCDF_CXX_INCLUDE_DIR=$NETCDFCXX4INCLUDE \
    -DLIBCONFIGPP_INCLUDE_DIR=/Users/tyounkin/Code/libconfigBuild/include \
    -DBoost_DIR=/usr/local/Cellar/boost/1.67.0_1/ \
    -DBoost_INCLUDE_DIR=/usr/local/Cellar/boost/1.67.0_1/include \
    -DUSE_CUDA=0 \
    -DUSEMPI=0 \
    -DUSE_MPI=1 \
    -DUSE_OPENMP=0 \
    -DUSE_BOOST=1 \
    -DUSEIONIZATION=0 \
    -DUSERECOMBINATION=0 \
    -DUSEPERPDIFFUSION=0 \
    -DUSECOULOMBCOLLISIONS=0 \
    -DUSETHERMALFORCE=0 \
    -DUSESURFACEMODEL=0 \
    -DUSESHEATHEFIELD=0 \
    -DBIASED_SURFACE=0 \
    -DUSEPRESHEATHEFIELD=0 \
    -DBFIELD_INTERP=0 \
    -DLC_INTERP=0 \
    -DGENERATE_LC=0 \
    -DEFIELD_INTERP=0 \
    -DPRESHEATH_INTERP=0 \
    -DDENSITY_INTERP=0 \
    -DTEMP_INTERP=0 \
    -DFLOWV_INTERP=0 \
    -DGRADT_INTERP=0 \
    -DODEINT=0 \
    -DFIXEDSEEDS=0 \
    -DPARTICLESEEDS=1 \
    -DGEOM_TRACE=0 \
    -DGEOM_HASH=0 \
    -DGEOM_HASH_SHEATH=0 \
    -DPARTICLE_TRACKS=1 \
    -DPARTICLE_SOURCE_SPACE=0 \
    -DPARTICLE_SOURCE_ENERGY=0 \
    -DPARTICLE_SOURCE_ANGLE=0 \
    -DPARTICLE_SOURCE_FILE=1 \
    -DSPECTROSCOPY=2 \
    -DUSE3DTETGEOM=0 \
    -DUSECYLSYMM=1 \
    -DUSEFIELDALIGNEDVALUES=1 \
    -DFLUX_EA=1 \
    -DCHECK_COMPATIBILITY=1 \
    ..