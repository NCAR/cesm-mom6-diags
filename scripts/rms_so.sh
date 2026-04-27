#!/bin/bash
#PBS -N rms_so
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=40GB
#PBS -l walltime=06:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
conda activate /glade/work/gmarques/conda-envs/mom6-tools

drift.py diag_config.yml so --rms -nw 12
