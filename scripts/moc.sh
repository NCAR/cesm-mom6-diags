#!/bin/bash
#PBS -N moc
#PBS -A NCGD0011
#PBS -l select=1:ncpus=1:mem=40GB
#PBS -l walltime=01:00:00
#PBS -q casper
#PBS -j oe

source ~/.bashrc
module load conda
conda activate mom6-tools

moc.py diag_config.yml -nw 6
