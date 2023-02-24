#FINDING VARIANTS

#Please open README file first and install necessary packages

#Load packages
library("maftools")
library("RColorBrewer")
library("R.utils")


#Set your own working directory
setwd("~/YOUR/WORKING/DIRECTORY")

#Define your input.maf file.
inputMAF<-"citopenia.maf"
#Define your output names
out_name <- "maftools_output"

#MAF validation and obtaining variants number and mutations for each sample
maf_1<-read.maf(maf = inputMAF)
getSampleSummary(maf_1)
getGeneSummary(maf_1)
write.mafSummary(maf = maf_1, basename = out_name)
#Read control file to compare results
control="Control.maf"
maf_2<-read.maf(maf = control)
getSampleSummary(maf_2)
getGeneSummary(maf_2)
write.mafSummary(maf = maf_2, basename = 'control')
#Create mutation plots and transition transversion ratios.
png("maftools_maf1Summary.png", w=1100, h=800, pointsize=22)
plotmafSummary(maf = maf_1, 
               rmOutlier = TRUE, 
               addStat = 'median', 
               dashboard = TRUE, 
               titvRaw = TRUE)
dev.off()
#Define different colors for mutations
vc_cols <- RColorBrewer::brewer.pal(n = 8, name = 'Pastel1')
names(vc_cols) = c(
  'Frame_Shift_Del',
  'Missense_Mutation',
  'Nonsense_Mutation',
  'Multi_Hit',
  'Frame_Shift_Ins',
  'In_Frame_Ins',
  'Splice_Site',
  'In_Frame_Del'
)
print(vc_cols)
#If GSTIC results are missing, create a dummy set to simulate a plot
set.seed(seed = 1024)
barcodes <- as.character(getSampleSummary(x = maf_1)[,Tumor_Sample_Barcode])
dummy.samples <- sample(x = barcodes,
                       size = dim(maf_1@variant.type.summary)[1], 
                       replace = FALSE)
cn.status <- sample(
  x = c('ShallowAmp', 'DeepDel', 'Del', 'Amp'),
  size = length(dummy.samples),
  replace = TRUE
)
custom.cn.data <- data.frame(
  Gene = "MUC6", #try with other genes
  Sample_name = dummy.samples,
  CN = cn.status,
  stringsAsFactors = FALSE
)
#Try with different treatments or diseases
head(custom.cn.data)
maf_1.plus.cn <- read.maf(maf = inputMAF,
                        cnTable = custom.cn.data,
                        verbose = FALSE)
#Oncoplot with dummy set to detect CNV and gene pathways 
oncoplot(maf = maf_1.plus.cn, 
         top = 20,
         fontSize = 0.4, 
         colors = "Pastel1", 
         showTitle = FALSE, 
         pathways = "auto", 
         gene_mar = 8 ) 
#Compare mutations in control and treatment group with p-value=0.5
pt.vs.rt <- mafCompare(m1 = maf_1, m2 = maf_2, m1Name = 'citopenia', m2Name = 'Control', minMut = 5)
print(pt.vs.rt)
#Plot differences in forest plot
apl.pt.vs.rt.fp <- forestPlot(mafCompareRes = pt.vs.rt, pVal = 0.05, geneFontSize = 0.5, color = c('royalblue', 'maroon')) 
#Plot allelic variants for each data set
plotVaf(maf = maf_1)
#Plot aminoacid changes in proteic domains according to PFAM
laml.pfam <- pfamDomains(maf = maf_1, AACol = 'Protein_Change', top = 10)
#Predict genes or gene products that interact with drugs, ideally with a therapeutic benefit to the patient (https://www.dgidb.org/about)
dgi <- drugInteractions(maf = maf_1, fontSize = 0.75)
#Create enrichment plot using Oncogenic Signaling Pathways in TCGA cohorts
#do it for each input file
OncogenicPathways(maf = maf_1)
#Explore a particular pathway
PlotOncogenicPathways(maf = maf_1, pathways = "RTK-RAS")

