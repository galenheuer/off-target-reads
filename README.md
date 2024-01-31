# off-target-reads
The use of off-target reads from cfDNA as biomarkers for ALS

Background: 
Cell-free DNA or circulating free DNA (cfDNA) is released into bodily fluids after cell death. It has been shown that cfDNA concentration and composition varies under certain conditions such as cancer, pregnancy, etc., which introduces the idea of using cfDNA as a diagnostic tool for disease. This could be particularly useful for neurodegenerative diseases like ALS, which are characterized by cell death, and that take a long time to diagnose, often to the point where patients progress beyond the point of lifesaving treatment while waiting to verify a diagnosis. While cfDNA has been well characterized in other disease applications, its application in neurodegeneration remains unexplored.

To better characterize cfDNA in the context of neurodegeneration, we propose analyzing whole genome sequencing data from the blood serum of ALS patients. In particular, some sequencing reads from cfDNA do not map to the human genome, but instead map to mitochondrial DNA or microbial DNA from the host microbiome. Recent work has found that these off-target reads may be informative in non-invasively characterizing disease (Blacher et al. 2019). This presents an additional opportunity to identify relationships between these ‘off-target reads’ and ALS disease status or progression, which could reflect variations in microbiome composition or metabolic differences. For these purposes, Kraken is a taxonomic classification algorithm that can be used to identify which microorganism genomes are present in a cfDNA sample (Poore et al. 2020).

Hypothesis: 
There is a relationship between off-target cfDNA composition and ALS disease state, which could be used as a biomarker for diagnosis and disease progression.

Tentative steps:
Preprocess reference genomes and use them to build a custom Kraken database for comparison to patient samples
Run Kraken algorithm to determine microbial composition
Additional QC steps to ensure proper estimation of matches with microbial reads
Identify reads mapping to mitochondrial human genome 
Correlate with ALS (and potentially other disease) biology

Related research:
Blacher, E., Bashiardes, S., Shapiro, H. et al. Potential roles of gut microbiome and metabolites in modulating ALS in mice. Nature 572, 474–480 (2019). https://doi.org/10.1038/s41586-019-1443-5
Poore, G.D., Kopylova, E., Zhu, Q. et al. Microbiome analyses of blood and tissues suggest cancer diagnostic approach. Nature 579, 567–574 (2020). https://doi.org/10.1038/s41586-020-2095-1
