# Waste-Water-SARS-CoV2
Waste water analysis using Freyja pipeline with Automation

To run the pipeline 
1. Give executable permission to freyja-run
   
chmod +x freyja-run

2. Keep your FASTQ files in a directory
3. Keep the reference in a directory eg: /home/SARS/*All the files .dict, .fasta, .amb, .ann, .bwt, .fai, .pac, .sa

To run the pipeline use ./freyja-run

Enter the reference genome path: Path to your directory eg: /home/SARS/SARSCoV2_genome.fasta 

Enter the FASTQ directory path: Path to a directory containing FASTQ files (.gz) eg: /home/SARS/FASTQ/

Enter the output directory path: Path to get the results eg: /home/SARS/Result



Please refer original github repository for this analysis 

https://github.com/andersen-lab/Freyja
