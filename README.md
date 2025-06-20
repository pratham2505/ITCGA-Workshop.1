# ITCGA-Workshop.1

Data Link:
https://www.ncbi.nlm.nih.gov/sra?term=SRP557307

Nitric Oxide (NO) in IFN-γ–Activated Macrophages: ITCGA Summer Workshop Project
Hello! This project is part of the Summer ITCGA Workshop at UMass Boston, in collaboration with Dana-Farber: Integrated Training in Computational Genomics and Data Sciences.

Project Overview:

Nitric Oxide (NO) is a signaling molecule produced by immune cells, especially macrophages, in response to inflammatory signals like Interferon-gamma (IFN-γ).

NO is generated through NOS2 (iNOS) expression and plays critical roles in:

Regulating gene expression in activated macrophages

Altering metabolic pathways such as NAD⁺ production

Shaping immune responses against pathogens and tumors

This study investigates NO's impact on the transcriptional and metabolic reprogramming of IFN-γ–stimulated macrophages.

Focused on distinguishing NO-dependent vs. NO-independent gene regulation

Evaluated the role of NO in linking IFN-γ signaling to immune and metabolic outputs

RNA-seq Analysis Pipeline on Chimera Cluster
Download FastQ Files

Used fasterq-dump and custom SLURM scripts to download raw sequencing data from SRA

Quality Control

Verified sequencing quality with FastQC

Adapter Trimming

Removed Illumina adapters and low-quality bases using cutadapt

Used SLURM batch processing for trimming multiple files

Genome Alignment

Aligned reads to the mouse genome (mm10) using STAR

Feature Counting

Quantified gene expression levels using FeatureCounts

Differential Expression Analysis

Performed with DESeq2 to compare:

Control vs. IFN-γ

Control vs. LNMA (NO-inhibited)

IFN-γ vs. IFN-γ + LNMA (isolating NO-dependent changes)

