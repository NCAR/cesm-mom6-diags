#!/bin/bash
#PBS -N aaiw_pv
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=4GB
#PBS -l walltime=01:00:00
#PBS -q casper
#PBS -j oe

module load conda
conda activate mom6-tools

mom6-tools_aaiw_pv diag_config.yml -nw 6
