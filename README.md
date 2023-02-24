# maftools-in-R
__maftools__ is a bioinformatic package use to annotate mutations and find variants. Full documentation can be found online. 

https://bioconductor.org/packages/release/bioc/vignettes/maftools/inst/doc/maftools.html

### __FILE INPUTS__

- (required) MAF file - can be gz compressed.
- (optional) clinical data associated with each sample/Tumor_Sample_Barcode in MAF.
- (optional) copy number data if available. Can be GISTIC output or a custom table containing sample names, gene names and copy-number status (Amp or Del).

### __FILE OUTPUTS__

- Gene Summary (txt)
- Sample Summary (txt)
- Summary (txt)
- Clinical Data (txt)
- Maftools Output (maf)
- Summary plots (png)


### __PACKAGE REQUIREMENTS__

Install required libraries from Bioconductor

*Run this code if the packages are not already installed*

    if (!require("BiocManager"))
      install.packages("BiocManager")
    BiocManager::install("maftools")
    
    install.packages("R.utils")

### __Load required libraries__

    library("maftools")
    library("RColorBrewer")
    library("R.utils")

