# maftools-in-R
maftools is a bioinformatic package use to annotate mutations and find variants. Full documentation can be found online. 

https://bioconductor.org/packages/release/bioc/vignettes/maftools/inst/doc/maftools.html

##FILE INPUTS

- (required) MAF file - can be gz compressed.
- (optional) clinical data associated with each sample/Tumor_Sample_Barcode in MAF.
- (optional) copy number data if available. Can be GISTIC output or a custom table containing sample names, gene names and copy-number status (Amp or Del).

##FILE OUTPUTS

- Gene Summary (txt)
- Sample Summary (txt)
- Summary (txt)
- Clinical Data (txt)
- Maftools Output (maf)
- Summary plots (png)


##PACKAGE REQUIREMENTS

--Install required libraries from Bioconductor
Run this code if the packages are not already installed

'''
if (!require("BiocManager"))
  install.packages("BiocManager")
BiocManager::install("maftools")
install.packages("R.utils")
'''

##Load required libraries

'''
library("maftools")
library("RColorBrewer")
library("R.utils")
'''
