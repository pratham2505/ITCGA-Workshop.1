#!/bin/bash

#SBATCH --job-name=hisat2-build
#SBATCH -n 1
#SBATCH --cpus-per-task=40
#SBATCH --time=00-23:00:00
#SBATCH --mem=128gb
#SBATCH --error=logs/%x_%A.err
#SBATCH --output=logs/%x_%A.out
#SBATCH --partition=Intel6248,Intel6326
#SBATCH --account=math

eval "$(conda shell.bash hook)"
conda activate sep_ml

echo "Starting HISAT2 index build..."

hisat2-build --ss splicesites.txt --exon exons.txt \
             -p 40 \
             Mus_musculus.GRCm38.dna.primary_assembly.fa \
             grcm38_hisat2_index

echo "HISAT2 index build completed."
