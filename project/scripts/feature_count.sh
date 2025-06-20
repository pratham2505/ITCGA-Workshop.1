#!/bin/bash

#SBATCH --job-name=fc # you can give your job a name
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

# === Paths ===
gtf_file=../genome/Mus_musculus.GRCm38.90.gtf
bam_dir=../samtools/sorted_bam
out_dir=../feature_count/output_counts

mkdir -p "$out_dir"

echo "Starting featureCounts..."

for bam in "$bam_dir"/*_sorted.bam; do
    sample=$(basename "$bam" _sorted.bam)
    echo "Counting features for $sample"
    
    featureCounts -a "$gtf_file" \
                  -o "$out_dir/${sample}_counts.txt" \
                  -T 40 -p -B -C "$bam"
    
    echo "Finished $sample"
done

echo "All featureCounts jobs completed."