#!/bin/bash
#PBS -N basin_reductions
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=4GB
#PBS -l walltime=01:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
conda activate  /glade/work/gmarques/conda-envs/mom6-tools

compute_basin_reductions.py diag_config.yml
