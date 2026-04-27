#!/bin/bash
#PBS -N climo_native
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=4GB
#PBS -l walltime=06:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
conda activate /glade/work/gmarques/conda-envs/mom6-tools

create_climatology.py diag_config.yml  -s .mom6.h.native.????-??.nc  -f native
