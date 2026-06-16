#!/bin/bash
#PBS -N rms_thetao
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=40GB
#PBS -l walltime=06:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
module load conda
conda activate mom6-tools

mom6-tools_drift diag_config.yml thetao --rms -nw 12
