#!/bin/bash

#SBATCH --job-name=cutadapt # you can give your job a name
#SBATCH --nodes 1 # the number of processors or tasks
#SBATCH --cpus-per-task=16
#SBATCH --account=itcga # our account
#SBATCH --time=6:00:00 # the maximum time for the job
#SBATCH --mem=32gb # the amount of RAM
#SBATCH --partition=itcga # the specific server in chimera we are using
#SBATCH --reservation=2025_JUNE_ITCGA_WORKSHOP #This reservation lets us cut in line to use itcga cores
#SBATCH --error=logs/%x-%A_%a.err   # a filename to save error messages into
#SBATCH --output=logs/%x-%A_%a.out  # a filename to save any printed output into

module load py-dnaio-0.4.2-gcc-10.2.0-gaqzhv4
module load py-xopen-1.1.0-gcc-10.2.0-5kpnvqq
module load py-cutadapt-2.10-gcc-10.2.0-2x2ytr5
module load gcc-10.2.0-gcc-9.3.0-f3oaqv7
module load hisat2-2.1.0-gcc-9.3.0-u7zbyow
module load samtools-1.10-gcc-9.3.0-flukja5
module load subread-2.0.2-gcc-10.2.0

input_dir=~/final_project/data/raw_fastq # takes this from the command line, first item after the script
output_dir=/mathspace/data01/mohammad.hemmati001/iTCGA_workshop/trimmed_fastq # takes this from the command line, second item

echo "Cutadapt is running!"
for R1_fastq in ~/final_project/data/raw_fastq/*_1.fastq
do
# Pull basename
name=$(basename ${R1_fastq} _1.fastq)

echo $name

# Run cutadapt
cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
        --trim-n -m 25 --cores 8 \
        -o ${output_dir}/${name}_1_trim.fastq -p ${output_dir}/${name}_2_trim.fastq \
        ${input_dir}/${name}_1.fastq \
        ${input_dir}/${name}_2.fastq

echo "Cutadapt is finished trimming" ${name}

done

