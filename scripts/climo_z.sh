#!/bin/bash
#PBS -N climo_z
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=4GB
#PBS -l walltime=06:00:00
#PBS -q casper
#PBS -j oe

module load conda
conda activate mom6-tools

mom6-tools_create_climatology diag_config.yml  -s .mom6.h.z.*.nc  -f z
