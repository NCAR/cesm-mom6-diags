#!/bin/bash
#PBS -N notebooks
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=4GB
#PBS -l walltime=01:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
module load conda
conda activate mom6-tools

CASE="b.e30_alpha08b.B1850C_LTso.ne30_t232_wgx3.328"
COMPSET=BLT1850 # BLT1850 or GIAF

# generate_toc.py
python generate_toc.py
# generate_intro.py
python generate_intro.py
# ts_biases.ipynb
papermill ts_biases.ipynb ts_biases.ipynb
# moc.ipynb
papermill moc.ipynb moc.ipynb
# pht.ipynb
papermill pht.ipynb pht.ipynb
# mld.ipynb
papermill mld.ipynb mld.ipynb
# bld.ipynb
papermill bld.ipynb bld.ipynb
# transports.ipynb
papermill transports.ipynb transports.ipynb
# equatorial.ipynb
papermill equatorial.ipynb equatorial.ipynb
# ocean_stats.ipynb
papermill ocean_stats.ipynb ocean_stats.ipynb
# enso.ipynb
papermill enso.ipynb enso.ipynb
# aaiw_pv.ipynb
papermill aaiw_pv.ipynb aaiw_pv.ipynb
# ssh.ipynb
papermill ssh.ipynb ssh.ipynb
# build jupyter book
cd ../
jb build notebooks
cd notebooks
# send html to cgd server

umask 002
echo "Copying data to webext..."
ssh tungsten.cgd.ucar.edu "mkdir -p /project/diagnostics/external/${COMPSET}/$CASE/ocn/"
scp -r _build/html/* tungsten.cgd.ucar.edu:/project/diagnostics/external/${COMPSET}/$CASE/ocn/
echo "Modifying permissions on webext..."
ssh tungsten.cgd.ucar.edu "chmod -R 775 /project/diagnostics/external/${COMPSET}/$CASE/"
echo "Done with website creation and deployment!"

