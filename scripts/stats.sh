#!/bin/bash
#PBS -N stats
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=4GB
#PBS -l walltime=01:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
module load conda
conda activate mom6-tools

mom6-tools_stats diag_config.yml -ocean_stats -time_series -nw 6
