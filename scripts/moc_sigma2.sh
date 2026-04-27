#!/bin/bash
#PBS -N moc_sigma2
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=4GB
#PBS -l walltime=01:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
conda activate  /glade/work/gmarques/conda-envs/mom6-tools

moc_sigma2.py diag_config.yml -nw 6
