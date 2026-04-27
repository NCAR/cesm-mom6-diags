#!/bin/bash
#PBS -N transports
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=4GB
#PBS -l walltime=04:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
conda activate  /glade/work/gmarques/conda-envs/mom6-tools

section_transports.py diag_config.yml -save_ncfile -nw 6
