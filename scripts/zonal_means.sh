#!/bin/bash
#PBS -N zonal_means
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=10GB
#PBS -l walltime=02:00:00
#PBS -q casper
#PBS -j oe

module load conda
conda activate mom6-tools

mom6-tools_zonal_means diag_config.yml -nw 12
