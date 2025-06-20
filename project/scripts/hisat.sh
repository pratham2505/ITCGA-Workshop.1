#!/bin/bash

#SBATCH --job-name=hisat # you can give your job a name
#SBATCH --nodes 1 # the number of processors or tasks
#SBATCH --cpus-per-task=40
#SBATCH --account=math # our account
#SBATCH --time=6:00:00 # the maximum time for the job
#SBATCH --mem=64gb # the amount of RAM
#SBATCH --partition=Intel6248,Intel6326 # the specific server in chimera we are using
#SBATCH --error=logs/%x-%A_%a.err   # a filename to save error messages into
#SBATCH --output=logs/%x-%A_%a.out  # a filename to save any printed output into

eval "$(conda shell.bash hook)"
conda activate sep_ml

module load py-dnaio-0.4.2-gcc-10.2.0-gaqzhv4
module load py-xopen-1.1.0-gcc-10.2.0-5kpnvqq
module load py-cutadapt-2.10-gcc-10.2.0-2x2ytr5
module load gcc-10.2.0-gcc-9.3.0-f3oaqv7
module load hisat2-2.1.0-gcc-9.3.0-u7zbyow
module load samtools-1.10-gcc-9.3.0-flukja5
module load subread-2.0.2-gcc-10.2.0

input_dir=../trimmed_fastq # takes this from the command line, first $
output_dir=. # takes this from the command line, second item
ref=../genome/grcm38_hisat2_index

echo "Hisat2 is running"

for i in ${input_dir}/*_1_trimmed.fastq
do
  name=$(basename "$i" _1_trimmed.fastq)
  echo $name

  hisat2 -p 40 -x $ref \
  -1 ${input_dir}/${name}_1_trimmed.fastq \
  -2 ${input_dir}/${name}_2_trimmed.fastq \
  -S ${output_dir}/${name}.sam

  echo "hisat2 has finished running" ${name}
done

