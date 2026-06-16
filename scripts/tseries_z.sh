#!/bin/bash
#PBS -N tseries_z
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=4GB
#PBS -l walltime=06:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
module load conda
conda activate mom6-tools

mom6-tools_create_timeseries diag_config.yml  -s .mom6.h.z.*.nc
